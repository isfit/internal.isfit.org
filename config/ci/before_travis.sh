echo "Setting up database.yml for test (sqlite3)"
cp config/database.yml.example config/database.yml

# Set up database
echo "Set up test database"
bundle exec rake db:test:prepare
