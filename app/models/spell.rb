class Spell < ActiveRecord::Base
	attr_reader :id, :name

	def to_i; @id; end
	def to_s; @name; end

	def initialize(name, id, school)
		@name, @id, @school = name, id, school
	end


	def school
		case @school
			when SCHOOL_PHYSICAL
				"physical"
			when SCHOOL_HOLY
				"holy"
			when SCHOOL_FIRE
				"fire"
			when SCHOOL_NATURE
				"nature"
			when SCHOOL_FIRESTORM
				"firestorm"
			when SCHOOL_FROST
				"frost"
			when SCHOOL_FROSTFIRE
				"frostfire"
			when SCHOOL_FROSTSTORM
				"froststorm"
			when SCHOOL_SHADOW
				"shadow"
			when SCHOOL_SHADOWSTORM
				"shadowstorm"
			when SCHOOL_SHADOWFROST
				"shadowfrost"
			when SCHOOL_ARCANE
				"arcane"
			when SCHOOL_SPELLFIRE
				"spellfire"
			else
				"physical"
		end
	end
end
