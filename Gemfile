source 'http://rubygems.org'

gem 'rails', '3.2.12'

gem 'sqlite3'
gem 'mysql2'

# Asset template engines
gem 'compass', ">=0.12.rc.0"

# Spesifikke gems her
gem 'pry'
gem 'capistrano'
gem 'rvm-capistrano'
gem 'cancan'
gem 'rails-i18n', '~> 3.0.0'
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
gem 'rack-mini-profiler'
gem 'ransack'
gem 'simple_form'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'whenever', :require => false
gem 'bootstrap-datetimepicker-rails'

# Denne spammer oss med mail atm... Må tunes :P
gem 'exception_notification', "~>2.6.1", :require => 'exception_notifier'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'bootstrap-sass', '~>2.3.2.1'
end

group :development do
  # gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'nifty-generators'
  gem 'yard'
end

group :development, :test do
  gem 'capybara-webkit'
  gem 'rspec-rails'
  gem 'webrat'
  gem 'database_cleaner'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
	gem 'factory_girl_rails'
  gem 'selenium-webdriver'
	gem 'capybara'
	gem 'spork', "> 0.9.0rc"
	gem 'guard-rspec'
	gem 'guard-spork'
end
