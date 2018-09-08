require_relative './board'
require_relative './validators/board_state_validator.rb'
require_relative './validators/coordinate_validator.rb'
require_relative '../runners/determine_winner.rb'

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

  def self.score_of(player_id)
    Board.where(winner_id: player_id).count
  end

  def initialize(player_one_id, player_two_id, board = nil)
    @board = board || Board
      .new(player_one_id: player_one_id, player_two_id: player_two_id)
  end

  def start
    return board.errors.full_messages.join('. ') unless board.save

    self.started = true
    nil
  end

  def id
    board.id
  end

  def state
    {
      winner: board.winner_id,
      done: !board.winner_id.nil? || board_state.compact.size == 9,
      tied: board.winner_id.nil? && board_state.compact.size == 9
    }
  end

  def board_state
    board.state.clone
  end

  def place(coordinate, player_mark)
    return 'Game has not begun' unless started
    return "Game has ended, winner is #{board.winner_id}" if board.winner_id

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
    board.winner_id = DetermineWinner.new(board.state).run
    board.errors.full_messages.join('. ') unless board.save
  end

  private

  attr_reader :board
  attr_accessor :started
end
