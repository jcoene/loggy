class Event < ActiveRecord::Base
		attr_accessor :raw, :time, :event, :source, :dest, :spell

		attr_protected :amount, :overkill, :resisted, :blocked, :absorbed, :critical, :glancing, :crushing
		def to_s; @raw; end

		def parse(str)
			r = str.split(",")
			time, event = r[0].split("  ")

			@raw = str
			@time = Time.parse_wow(time)

			event = "SPELL_DAMAGE" if event == "DAMAGE_SHIELD" or event == "DAMAGE_SPLIT"
			event = "SPELL_MISSED" if event == "DAMAGE_SHIELD_MISSED"

			@event = event

			@source = Unit.new(r[2].unquote, r[1], r[3].to_i(16))
			@dest = Unit.new(r[5].unquote, r[4], r[6].to_i(16))

			case @event
				when /^SP/, /^RA/
					@spell = Spell.new(r[8].unquote, r[7].to_i, r[9].to_i(16))
					@params = r[10..-1]
				when /^SW/
					@spell = Spell.new("melee", 0, SCHOOL_PHYSICAL)
					@params = r[7..-1]
				when /^EN/
					@spell = Spell.new(r[7], 0, SCHOOL_PHYSICAL)
					@params = r[8..-1]
			end
		end

		def amount; @params[0].to_i; end
		def overkill; @params[1].to_i; end
		def resisted; @params[3].to_i; end
		def blocked; @params[4].to_i; end
		def absorbed; @event =~ /_DAMAGE$/ ? @params[5].to_i : @params[2].to_i; end
		def critical; @event =~ /_DAMAGE$/ ? @parmas[6].to_i : @params[3].to_i; end
		def glancing?; @params[7]==1; end
		def crushing?; @params[8]==1; end

		def type
			case @event
				when /_ENERGIZE$/, /_DRAIN$/, /_LEECH$/
					@params[1]
				when /_AURA_BROKEN_SPELL$/, /_DISPEL$/, /_STOLEN$/
					@params[3]
				when /_MISSED$/, /_AURA_/, /_CAST_FAILED$/
					@params[0]
			end
		end

		def extraspell
			case @event
				when /_INTERRUPT$/, /_DISPEL/, /_STOLEN$/, /_AURA_BROKEN_SPELL$/
					Spell.new(@params[1], @params[0].to_i, @params[2].to_i(16))
			end
		end

		def extraamount
			case @event
				when /_DRAIN$/, /_LEECH$/
					@params[2]
			end
		end

end
