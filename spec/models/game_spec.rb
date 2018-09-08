require_relative '../spec_helper'
require 'models/game.rb'

RSpec.describe Game do
  describe '#new' do
    it 'will set the default game state' do
      expect(Game.new.state).to eq([])
    end
  end

  describe '#create' do
    it 'will not create a new game without 2 players' do
      expect { Game.create }.to raise_error(ActiveRecord::NotNullViolation)
    end

    it 'will create a game with 2 players' do
      Game.create(player_one_id: 1, player_two_id: 2)
      expect(Game.count).to eq(1)
    end
  end

  describe '#place' do
    let(:game) { Game.create(player_one_id: 1, player_two_id: 2) }

    it 'will record player as placing a mark on coordinate' do
      error = game.place(2, 1)

      expect(error).to be_nil
      expect(game.state).to eq([nil, nil, 1])
    end

    it 'will not place a coordinate if it is out of bound' do
      error = game.place(10, 1)

      expect(error).to eq('Coordinate must be between 0 and 8')
      expect(game.state).to eq([])
    end

    it 'will not place a coordinate if it is already taken' do
      error = game.place(0, 1)

      expect(error).to be_nil
      expect(game.state).to eq([1])

      error = game.place(0, 2)

      expect(error).to eq('A mark already exists at coordinate: 0')
      expect(game.state).to eq([1])
    end
  end

  describe '#state' do
    it 'passes back a frozen array' do
      expect(Game.new.state.frozen?).to be_truthy
    end
  end

  describe '#state=' do
    it 'throws an exception to prevent clients from manually setting state' do
      expect { Game.new.state = [] }.to raise_error(NotImplementedError)
    end
  end
end
