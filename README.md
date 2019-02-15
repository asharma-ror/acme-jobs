# README

##Prerequisite

* Ruby version: v2.4.1
* System dependencies
MySql

##Setup and run process

###Get clone the repo: https://github.com/asharma-ror/acme-jobs.git

* Configuration
- Update config/database.yml
- Update config/trello.rb
- Set env variables `SIDEKIQ_USERNAME` and `SIDEKIQ_PASSWORD`

###Command to run before start
- `bundle install`
- `rake db:create db:migrate`

###Commands to Run application
- `rails s`
- `bundle exec sidekiq`

