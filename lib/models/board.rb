require_relative '../db/setup.rb'

class Board < ActiveRecord::Base
  after_initialize :set_default_state

  validate :different_players

  def player_ids
    [player_one_id, player_two_id]
  end

  private

  def different_players
    errors.add(:players, 'cannot play themselves') if player_ids.uniq.size < 2
  end

  def set_default_state
    write_attribute(:state, []) if state.nil?
  end
end
