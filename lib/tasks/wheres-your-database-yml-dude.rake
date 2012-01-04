file "config/database.yml.example" do |task|
  abort "I don't know what to tell you, dude. There's no #{task.name}. So maybe you should make one of those, and see where that gets you."
end

file "config/database.yml" => "config/database.yml.example" do |task|
  # This task will execute when the example file is newer than the main file (not just when it doesn't exist).
  unless File.exists?(task.name)
    puts "Dude! Where's your database.yml? I've put an example in place for you."
    cp task.prerequisites.first, task.name
    abort "Make sure it's cromulent to your setup, then rerun the last command."
  end
end

task :rails_env => "config/database.yml"
