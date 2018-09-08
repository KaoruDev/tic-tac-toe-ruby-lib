require 'models/board'
require 'models/validators/board_state_validator.rb'
require 'models/validators/coordinate_validator.rb'

class Game
  VALIDATORS = [
    CoordinateValidator,
    BoardStateValidator
  ].freeze

  def self.find(id)
    if (board = Board.find_by(id: id))
      [nil, new(nil, nil, board)]
    else
      ["Unable to find game with id: #{id}", nil]
    end
  end

  def initialize(player_one_id, player_two_id, board = nil)
    @board = board || Board
      .new(player_one_id: player_one_id, player_two_id: player_two_id)
  end

  def start!
    board.save!
    self.started = true
  end

  def id
    board.id
  end

  def place(coordinate, player_mark)
    return 'Game has not begun' unless started

    VALIDATORS.each do |validator|
      error = validator.new(
        board: board,
        player_mark: player_mark,
        state: board.state,
        coordinate: coordinate
      ).validate

      return error if error
    end

    board.state[coordinate] = player_mark
    board.errors.full_messages.join('. ') unless board.save
  end

  private

  attr_reader :board
  attr_accessor :started
end
