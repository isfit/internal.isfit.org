echo "Setting up database.yml for test (mysql)"
cp config/database.yml.example config/database.yml

mysql -e 'create database isfit13_internal_test;'

# Add secret
cp config/secrets.yml.example config/secrets.yml

# Set up database
echo "Set up test database"
bundle exec rake db:create
bundle exec rake db:schema:load
