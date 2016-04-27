# votecampaign
It is voting system for compaign to determine candidate score and message sent for candidate for particular campaign

### to run a repo.
1. git clone url
2. Create a database (rake db:create)
2. run rake task to import log data in application ( rake import:campaign)
3. start the rails server (rails s)
4. url -- http://localhost:3000/votes

sample database connection: config/database.yml

default: &default
  adapter: mysql2
  database: campaign
  username: root
  password: 

development:
  <<: *default

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: campaign_test

