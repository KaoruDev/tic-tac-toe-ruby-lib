require 'active_record'
require 'sqlite3'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.after(:example) do
    DatabaseCleaner.clean
  end
end

# silences migration load
ActiveRecord::Schema.verbose = false

# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :games, force: true do |t|
    t.belongs_to :player_one, null: false
    t.belongs_to :player_two, null: false
    t.belongs_to :winner
    t.json :state, null: false
  end
end
