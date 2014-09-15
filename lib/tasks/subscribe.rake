namespace :users do
  task :make_all_users_subscribe => :environment do
  	array = []

  	sections = Festival.find(4).sections
  	sections.each do |section|
  		section.groups.each do |group|
  			group.users.each do |user|
  				next if array.include? user.id
	  			Subscription.create(user_id: user.id, subscription_id: 1)
	  			Subscription.create(user_id: user.id, subscription_id: 2)
  				array << user.id
	  		end
  		end
  	end
  end
end