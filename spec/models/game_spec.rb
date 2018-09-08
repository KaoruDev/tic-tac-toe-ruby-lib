require_relative '../spec_helper'
require 'models/game.rb'

RSpec.describe Game do
  describe 'create' do
    it 'will create a new game' do
      Game.create

      expect(Game.count).to equal(1)
    end
  end
end
