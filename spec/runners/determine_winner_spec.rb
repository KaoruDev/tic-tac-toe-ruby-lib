require_relative '../spec_helper'
require 'runners/determine_winner.rb'

RSpec.describe DetermineWinner do
  describe '#run' do
    it 'will find the winner on horizontal marks' do
      [
        [
          1, 1, 1,
          nil, nil, 2,
          2, nil, 2
        ],
        [
          2, nil, nil,
          1, 1, 1,
          2, nil, 2
        ],
        [
          2, 2, nil,
          nil, nil, nil,
          1, 1, 1
        ]
      ].each do |board|
        expect(DetermineWinner.new(board).run).to eq(1)
      end
    end

    it 'will find the winner on vertical marks' do
      [
        [
          1, nil, 2,
          1, nil, nil,
          1, nil, 2
        ],
        [
          2, 1, nil,
          2, 1, 1,
          nil, 1, 2
        ],
        [
          2, 2, 1,
          nil, nil, 1,
          nil, 2, 1
        ]
      ].each do |board|
        expect(DetermineWinner.new(board).run).to eq(1)
      end
    end

    it 'will find the winner on diagonal marks' do
      [
        [
          1, nil, 2,
          2, 1, nil,
          1, nil, 1
        ],
        [
          2, nil, 1,
          2, 1, 1,
          1, nil, 2
        ]
      ].each do |board|
        expect(DetermineWinner.new(board).run).to eq(1)
      end
    end

    it 'will return nil if no winner is found' do
      [
        [],
        [
          1, nil, 2,
          2, 1, nil
        ],
        [
          1, 2, 1,
          2, 2, 1,
          1, 1, 2
        ]
      ].each do |board|
        expect(DetermineWinner.new(board).run).to be_nil
      end
    end
  end
end
