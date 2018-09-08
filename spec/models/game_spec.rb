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

    it 'will record player as placing a mark on coordinate 2' do
      game.place(2, 1)
    end
  end
end
