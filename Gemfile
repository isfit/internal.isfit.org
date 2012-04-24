source 'http://rubygems.org'

gem 'rails', '3.2.2'

gem 'sqlite3'
gem 'mysql2'

# Asset template engines
gem 'compass', ">=0.12.rc.0"

# Spesifikke gems her
gem 'capistrano'
gem 'cancan'
gem 'ancestry'
gem 'paperclip'
gem 'rack'
gem 'rake'
gem "bcrypt-ruby", :require => "bcrypt"
gem 'jquery-rails'
gem 'memcache-client'
gem 'therubyracer'
gem 'mini_magick', :require=>'RMagick'
gem 'rmagick', :require => false
gem 'bluecloth'
gem 'oauth2'
gem 'net-ldap'
gem 'jbuilder'
gem 'private_pub'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
#  gem 'bootstrap-sass'
end

group :production do 
  gem 'libnotify'
  gem 'rb-inotify'
end

group :development do
#  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'nifty-generators'
<<<<<<< HEAD
#  gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
#  gem 'growl' if /darwin/ =~ RUBY_PLATFORM
#  gem 'rb-inotify'
=======
>>>>>>> 16bca8921fd47cd50723908d992db5ab4913a3b2
  gem 'yard'
end

group :development, :test do
  gem 'mocha'
#  gem 'capybara-webkit'
  gem 'rspec-rails'
  #gem 'webrat'
  gem 'database_cleaner'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
	gem 'factory_girl_rails'
	gem 'capybara'
	gem 'spork', "> 0.9.0rc"
	gem 'guard-rspec'
	gem 'guard-spork'
end
