namespace :kvitter do

  desc "Update the teller count for all kvitters"
	task :count => :environment do
		Kvitter.find_each do |kvitter|
			puts "Reset counter for kvitter with id: #{kvitter.id}"
			Kvitter.reset_counters(kvitter, :awesomes)
		end
	end
end