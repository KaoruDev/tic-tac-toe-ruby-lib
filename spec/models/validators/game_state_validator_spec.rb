require_relative '../../spec_helper'
require_relative '../../helpers/game_spec_helper.rb'
require 'models/game.rb'
require 'models/validators/game_state_validator.rb'

RSpec.describe GameStateValidator do
  describe '#validate' do
    let(:game) { Game.new(player_one_id: 1, player_two_id: 2) }

    it 'will deem a new game valid' do
      GameStateValidator.new.validate(game)

      expect(game.errors.empty?).to be_truthy
    end

    it 'will deem a valid game state valid' do
      GameSpecHelper.set_state(game, [1, 2, 2, 1, 1, 2])
      GameStateValidator.new.validate(game)
      expect(game.errors.empty?).to be_truthy
    end

    it 'will deem a valid game state valid with nil values' do
      GameSpecHelper.set_state(game, [1, 2, 2, 1, nil, nil, 1, 2, 1])
      GameStateValidator.new.validate(game)
      expect(game.errors.empty?).to be_truthy
    end

    it 'makes sure game does not have an unknown player id' do
      game.place(4, 3)

      GameStateValidator.new.validate(game)

      expect(game.errors.empty?).to be_falsey

      # Turn base validation will not run if there's an unknown player id
      expect(game.errors[:state])
        .to contain_exactly('Unknown player with id: 3')
    end

    it 'makes sure player one does not go an extra round' do
      GameSpecHelper.set_state(game, [1, 2, 1, 1])
      GameStateValidator.new.validate(game)

      expect(game.errors.empty?).to be_falsey
      expect(game.errors[:state])
        .to contain_exactly('it is player two\'s turn')
    end

    it 'makes sure player two does not go an extra round' do
      GameSpecHelper.set_state(game, [1, 2, 2])
      GameStateValidator.new.validate(game)

      expect(game.errors.empty?).to be_falsey
      expect(game.errors[:state])
        .to contain_exactly('it is player one\'s turn')
    end
  end
end
