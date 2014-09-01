# RSpec.configure do |config|
#  config.before(:each) do
#    if example.metadata[:js]
#      DatabaseCleaner.clean
#      DatabaseCleaner.strategy = :truncation
#      Capybara.current_driver = :selenium # this can be removed with new Capybara release
#    end
#  end

#  config.after(:each) do
#    if example.metadata[:js]
#      DatabaseCleaner.clean
#      DatabaseCleaner.strategy = :transaction
#      DatabaseCleaner.start
#      #Capybara.use_default_driver # this can be removed with new Capybara release
#    end
#  end
# end
