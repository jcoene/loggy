
class Wow
	class Logfile

		def initialize(filename)
			@filename = filename
		end

		def events
			File.open(@filename, "r") do |f|
				while (line = f.gets)
					e = Event.new
					e.parse(line)
					e.spell_id = 7
					e.save
					yield e
				end
			end
		end

	end
end