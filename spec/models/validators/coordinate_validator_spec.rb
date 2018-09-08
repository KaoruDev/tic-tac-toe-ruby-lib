require_relative '../../spec_helper'
require 'models/game.rb'
require 'models/validators/coordinate_validator.rb'

RSpec.describe CoordinateValidator do
  describe '#validate' do
    let(:validator) { CoordinateValidator.new }

    it 'will return an error string if coordinate is out of bounds' do
      expect(validator.validate([], 10))
        .to eq('Coordinate must be between 0 and 8')

      expect(validator.validate([], -1))
        .to eq('Coordinate must be between 0 and 8')

      expect(validator.validate([], 20))
        .to eq('Coordinate must be between 0 and 8')
    end

    it 'will return an error string if a mark exists at coordinate' do
      expect(validator.validate([1], 0))
        .to eq('A mark already exists at coordinate: 0')
    end
  end
end
