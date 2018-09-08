require_relative '../spec_helper'
require 'models/board.rb'

RSpec.describe Board do
  describe '#new' do
    it 'will set the default board state' do
      expect(Board.new.state).to eq([])
    end
  end

  describe 'validates player id uniqueness' do
    it 'will ensure the player ids are unique' do
      board = Board.new(player_one_id: 1, player_two_id: 1)
      expect(board.valid?).to be_falsey
      expect(board.errors[:players])
        .to contain_exactly('cannot play themselves')
    end
  end

  describe '#create' do
    it 'will not create a new board without 2 not NULL player ids' do
      board = Board.create(player_one_id: nil, player_two_id: 'NULL')
      expect(board.valid?).to be_falsey
      expect(board.errors[:player_one_id]).to contain_exactly("can't be blank")

      board = Board.create(player_one_id: 'null', player_two_id: nil)
      expect(board.valid?).to be_falsey
      expect(board.errors[:player_two_id]).to contain_exactly("can't be blank")
    end

    it 'will create a board with 2 players' do
      Board.create(player_one_id: 1, player_two_id: 2)
      expect(Board.count).to eq(1)
    end
  end
end
