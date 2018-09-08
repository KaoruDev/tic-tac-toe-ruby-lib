require 'json'
require 'models/validators/game_state_validator.rb'

class Game < ActiveRecord::Base
  include ActiveModel::Validations

  after_initialize :set_default_state

  validates_with GameStateValidator

  def place(coordinate, player_id)
    # validate move
    # validate player turn
    # update state
  end

  private

  def set_default_state
    self.state ||= []
  end
end
