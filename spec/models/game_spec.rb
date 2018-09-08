require_relative '../spec_helper'
require 'models/game.rb'

RSpec.describe Game do
  let(:game) { Game.new(1, 2) }
  let(:started_game) { game.start! }

  describe '.find' do
    it 'will reinitialize game' do
      id = started_game.id

      expect(Game.find(id)[1].id).to eq(id)
    end

    it 'will return an error if game cannot be found' do
      error, _game = Game.find(20)

      expect(error).to eq('Unable to find game with id: 20')
    end
  end

  describe '#start!' do
    it 'will start a valid game' do
      Game.new(1, 2).start!
    end

    it 'will throw an exception if game state is invalid' do
      expect { Game.new(nil, 'NULL').start! }
        .to raise_exception(ActiveRecord::NotNullViolation)

      expect { Game.new(1, 1).start! }
        .to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  describe '#place' do
    it 'will return an error if game has not begun' do
      error = game.place(1, 2)

      expect(error).to eq('Game has not begun')
    end

    it 'will return an error if coordinate is out of bound' do
      expect(started_game.place(10, 1))
        .to eq('Coordinate must be between 0 and 8')

      expect(started_game.place(-1, 1))
        .to eq('Coordinate must be between 0 and 8')

      expect(started_game.place(20, 1))
        .to eq('Coordinate must be between 0 and 8')
    end

    it 'will return an error string if a mark exists at coordinate' do
      expect(started_game.place(0, 1)).to be_nil
      expect(started_game.place(0, 2))
        .to eq('A mark already exists at coordinate: 0')
    end

    it 'return an error player is out of turn' do
      expect(started_game.place(0, 1)).to be_nil
      expect(started_game.place(1, 1)).to eq("it is player two's turn")
      expect(started_game.place(1, 2)).to be_nil
      expect(started_game.place(2, 2)).to eq("it is player one's turn")
    end

    it 'will return an error if player id is unknown' do
      expect(started_game.place(0, 3)).to eq('Unknown player with id: 3')
    end

    it 'will save the state' do
      expected_state = [1, nil, 2, nil, nil, 1]

      expect(started_game.place(0, 1)).to be_nil
      expect(started_game.place(2, 2)).to be_nil
      expect(started_game.place(5, 1)).to be_nil
      expect(started_game.board_state).to eq(expected_state)

      id = started_game.id

      expect(Game.find(id)[1].board_state).to eq(expected_state)
    end

    it 'will return error if game has already ended' do
      expect(started_game.place(0, 1)).to be_nil
      expect(started_game.place(1, 2)).to be_nil
      expect(started_game.place(3, 1)).to be_nil
      expect(started_game.place(2, 2)).to be_nil
      expect(started_game.place(6, 1)).to be_nil

      expect(started_game.place(5, 2)).to eq('Game has ended, winner is 1')
    end
  end

  describe '#winner' do
    it 'will return nil when no winner has been declared' do
      expect(started_game.winner).to be_nil
    end

    it 'will return the id of the winner' do
      expect(started_game.place(0, 1)).to be_nil
      expect(started_game.place(1, 2)).to be_nil
      expect(started_game.place(3, 1)).to be_nil
      expect(started_game.place(2, 2)).to be_nil
      expect(started_game.place(6, 1)).to be_nil

      expect(started_game.winner).to eq(1)
    end
  end
end
