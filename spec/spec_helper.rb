require "active_record"
require "sqlite3"

# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :games, force: true do |t|
    t.belongs_to :player_one
    t.belongs_to :player_two
    t.belongs_to :winner
    t.string :state
  end
end

