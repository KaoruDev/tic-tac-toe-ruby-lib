class BoardStateValidator
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def validate
    detect_unknown_player || detect_uneven_turn
  end

  private

  def detect_unknown_players
    unknown_players =
      board.state - [board.player_one_id, board.player_two_id, nil]

    unless unknown_players.empty?
      "Unknown player with id: #{unknown_players.first}"
    end
  end

  def detect_uneven_turn
    player_one_turns, player_two_turns =
      board.state.partition { |player| player == board.player_one_id }

    player_two_turns = player_two_turns.compact

    difference = player_one_turns.count - player_two_turns.count

    if difference > 1
      "it is player two's turn"
    elsif difference.negative?
      "it is player one's turn"
    end
  end
end
