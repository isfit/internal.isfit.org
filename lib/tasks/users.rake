namespace :users do
  task :get_number_of_users_in_groups => :environment do
    sections = Festival.find(4).sections

    puts "ISFiT 2015 til sammen: #{ Festival.find(4).users.map(&:id).uniq.length.to_s }\n\n"

    board = Group.find(123)
    puts "#{ board.name_no.to_s }: #{ board.users.count.to_s }"

    sections.each do |section|
      puts section.name_no.to_s + ": "+ section.users.map{|u| u.id }.uniq.length.to_s
      section.groups.each do |group|
        puts "  " + group.name_no.to_s + ": " + group.users.count.to_s
      end
    end

    research = Group.find(159)
    puts research.name_no.to_s + ": " + research.users.count.to_s
  end
end
