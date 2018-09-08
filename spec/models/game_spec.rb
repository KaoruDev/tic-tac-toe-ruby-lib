require_relative '../spec_helper'
require 'models/game.rb'

RSpec.describe Game do
  describe '#start' do
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
    let(:game) { Game.new(1, 2) }

    it 'will return an error if game has not begun' do
      error = game.place(1, 2)

      expect(error).to eq('Game has not begun')
    end

    it 'will return an error if coordinate is out of bound' do
      game.start!

      expect(game.place(10, 1))
        .to eq('Coordinate must be between 0 and 8')

      expect(game.place(-1, 1))
        .to eq('Coordinate must be between 0 and 8')

      expect(game.place(20, 1))
        .to eq('Coordinate must be between 0 and 8')
    end

    it 'will return an error string if a mark exists at coordinate' do
      game.start!
      expect(game.place(0, 1)).to be_nil
      expect(game.place(0, 2)).to eq('A mark already exists at coordinate: 0')
    end
  end
end
