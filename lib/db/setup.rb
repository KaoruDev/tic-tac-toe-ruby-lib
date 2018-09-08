require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :boards, force: true do |t|
    t.belongs_to :player_one, null: false
    t.belongs_to :player_two, null: false
    t.belongs_to :winner
    t.json :state, null: false
  end
end
