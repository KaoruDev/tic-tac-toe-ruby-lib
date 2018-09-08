require 'json'
require 'models/validators/game_state_validator.rb'
require 'models/validators/coordinate_validator.rb'

class Game < ActiveRecord::Base
  include ActiveModel::Validations

  after_initialize :set_default_state

  validates_with GameStateValidator

  def place(coordinate, player_id)
    if (error = CoordinateValidator.new.validate(state, coordinate))
      return error
    end

    new_state = state.dup
    new_state[coordinate] = player_id

    write_attribute(:state, new_state)
    return nil # rubocop:disable Style/RedundantReturn
  end

  def state
    super.dup.freeze
  end

  def state=(_new_state)
    raise NotImplementedError, 'You may not directly set state'
  end

  private

  def set_default_state
    write_attribute(:state, []) if state.nil?
  end
end
