require_relative '../../spec_helper'
require 'models/game.rb'
require 'models/validators/coordinate_validator.rb'

RSpec.describe CoordinateValidator do
  describe '#validate' do
    it 'will return an error string if coordinate is out of bounds' do
      expect(CoordinateValidator.new(state: [], coordinate: 10).validate)
        .to eq('Coordinate must be between 0 and 8')

      expect(CoordinateValidator.new(state: [], coordinate: -1).validate)
        .to eq('Coordinate must be between 0 and 8')

      expect(CoordinateValidator.new(state: [], coordinate: 20).validate)
        .to eq('Coordinate must be between 0 and 8')
    end

    it 'will return an error string if a mark exists at coordinate' do
      expect(CoordinateValidator.new(state: [1], coordinate: 0).validate)
        .to eq('A mark already exists at coordinate: 0')
    end
  end
end
