class GameStateValidator < ActiveModel::Validator
  def validate(game)
    return unless game.state_changed?
    detect_unknown_players(game)
    detect_uneven_turn(game) if game.errors.empty?
  end

  private

  def detect_unknown_players(game)
    unknown_players = game.state - [game.player_one_id, game.player_two_id, nil]

    unless unknown_players.empty?
      game.errors
        .add(:state, "Unknown player with id: #{unknown_players.first}")
    end
  end

  def detect_uneven_turn(game)
    player_one_turns, player_two_turns =
      game.state.partition { |player| player == game.player_one_id }

    player_two_turns = player_two_turns.compact

    difference = player_one_turns.count - player_two_turns.count

    if difference > 1
      game.errors.add(:state, "it is player two's turn")
    elsif difference.negative?
      game.errors.add(:state, "it is player one's turn")
    end
  end
end
