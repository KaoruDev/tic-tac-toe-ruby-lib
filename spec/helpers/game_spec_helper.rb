class GameSpecHelper
  def self.set_state(game, state)
    state.each_with_index do |player_id, coordinate|
      if (error = game.place(coordinate, player_id))
        raise "Encountered error when placing coordinate in tests: #{error}"
      end
    end
  end
end
