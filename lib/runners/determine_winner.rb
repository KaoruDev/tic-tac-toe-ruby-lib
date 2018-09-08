class DetermineWinner
  attr_reader :board_state

  WINNING_COMBONIATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize(board_state)
    @board_state = board_state
  end

  def run
    WINNING_COMBONIATIONS.each do |combo|
      marks = combo.map do |combo_idx|
        board_state[combo_idx]
      end

      if !marks.include?(nil) && (uniq_marks = marks.compact.uniq).count == 1
        return uniq_marks.first
      end
    end

    nil
  end
end
