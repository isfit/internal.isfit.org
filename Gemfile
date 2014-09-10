source 'http://rubygems.org'

gem 'rails', '4.1.0'

gem 'sqlite3'
gem 'mysql2'

# Asset template engines
gem 'compass'

# Spesifikke gems her
gem 'capistrano', '~> 3.1'
gem 'capistrano-rails', '~> 1.1'
gem 'capistrano-rvm'
gem 'cancancan', '~> 1.9'
gem 'rails-i18n'
gem 'ancestry'
gem 'paperclip'
gem 'rack'
gem 'rake'
gem "bcrypt-ruby", :require => "bcrypt"
gem "jquery-rails", "~> 3.1.1"
gem "jquery-ui-rails"
gem 'memcache-client'
gem 'therubyracer'
gem 'mini_magick', :require=>'RMagick'
gem 'rmagick', :require => false
gem 'bluecloth'
gem 'oauth2'
gem 'net-ldap'
gem 'jbuilder'
gem 'private_pub'
#gem 'rack-mini-profiler'
gem 'ransack'
gem 'activemodel'
gem 'simple_form', '~> 3.1.0.rc2'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'whenever', :require => false

# Denne spammer oss med mail atm... Må tunes :P
gem 'exception_notification', "~>4.0.1", :require => 'exception_notifier'

gem 'sass-rails', '~> 4.0.3'
gem 'coffee-rails', '~> 4.0.1'
gem 'uglifier', '>= 1.3.0'
gem 'bootstrap-sass', '~> 3.2.0'
#gem 'bootstrap-datepicker-rails'
gem 'momentjs-rails', '~> 2.8.1'
gem 'datetimepicker-rails', :git => 'git://github.com/zpaulovics/datetimepicker-rails.git',  \
    :branch => 'master', :submodules => true

group :development do
  # gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'nifty-generators'
  gem 'pry'
  gem 'yard'
end

group :development, :test do
  #gem 'capybara-webkit'
  gem 'rspec-rails'
  gem 'webrat'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  #gem 'selenium-webdriver''
  gem 'capybara-webkit'
	gem 'capybara'
  gem 'spork-rails', '~> 4.0.0'
	gem 'guard-rspec'
	gem 'guard-spork'
end
