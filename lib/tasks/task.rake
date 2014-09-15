namespace :users do
  task :get_number_of_users_in_groups => :environment do
  	sections = Festival.find(4).sections
  	sections.each do |section|
  		puts section.name_no.to_s + ": "+ section.users.count.to_s
  		section.groups.each do |group|
  			puts "  " + group.name_no.to_s + ":" + group.users.count.to_s
  		end
  	end
  end
end
