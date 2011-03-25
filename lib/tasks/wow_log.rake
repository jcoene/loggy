namespace :wow do

	namespace :log do

		desc "Import a given logfile"
		task :import => :environment do
			filename = ENV['file']
			suicide "No such file!" if !filename or !File.file?(filename)
			log = Wow::Logfile.new(filename)

			start = Time.now
			n=0
			log.events do |e|
				n += 1
				moan "%s > %s" % [e.source.to_s, e.dest.to_s]
				break if n > 5
			end

			done = Time.now
			sec = (done-start).ceil
			persec = (n/sec).ceil

			moan "Processed %d lines in %d sec, %d lines/sec" % [n, sec, persec]
		end

	end

end

def moan(what)
	print "%2d:%2d:%2d: %s\n" % [Time.now.hour, Time.now.min, Time.now.sec, what]
end

def suicide(why)
	print "Giving up: %s\n" % why
	exit
end