class BoardStateValidator
  attr_reader :board, :player_mark

  def initialize(configs = {})
    @board = configs[:board]
    @player_mark = configs[:player_mark]
  end

  def validate
    detect_unknown_player || detect_uneven_turn
  end

  private

  def detect_unknown_player
    unless board.player_ids.include?(player_mark)
      "Unknown player with id: #{player_mark}"
    end
  end

  def detect_uneven_turn
    player_moves = board.state.clone
    player_moves.push(player_mark)

    player_one_turns, player_two_turns =
      player_moves.partition { |player| player == board.player_one_id }

    difference = player_one_turns.count - player_two_turns.compact.count

    if difference > 1
      "it is player two's turn"
    elsif difference.negative?
      "it is player one's turn"
    end
  end
end
