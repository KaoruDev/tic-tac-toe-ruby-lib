require_relative '../../spec_helper'
require 'models/board.rb'
require 'models/validators/board_state_validator.rb'

RSpec.describe BoardStateValidator do
  describe '#validate' do
    let(:board) { Board.new(player_one_id: 1, player_two_id: 2) }

    it 'will deem a new board valid' do
      expect(BoardStateValidator.new(board, 1).validate).to be_nil
    end

    it 'will deem a valid game state valid' do
      board.state = [1, 2, 2, 1, 1, 2]
      expect(BoardStateValidator.new(board, 1).validate).to be_nil
    end

    it 'will deem a valid game state valid with nil values' do
      board.state = [1, 2, 2, 1, nil, nil, 1, 2, 1]
      expect(BoardStateValidator.new(board, 2).validate).to be_nil
    end

    it 'makes sure game does not have an unknown player id' do
      expect(BoardStateValidator.new(board, 3).validate)
        .to eq('Unknown player with id: 3')
    end

    it 'makes sure player one does not go an extra round' do
      board.state = [1, 2, 1]

      expect(BoardStateValidator.new(board, 1).validate)
        .to eq("it is player two's turn")
    end

    it 'makes sure player two does not go an extra round' do
      board.state = [1, 2]

      expect(BoardStateValidator.new(board, 2).validate)
        .to eq("it is player one's turn")
    end
  end
end
