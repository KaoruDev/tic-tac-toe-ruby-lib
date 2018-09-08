class CoordinateValidator
  MAX_COORDINATE = 8

  attr_reader :state, :coordinate

  def initialize(configs = {})
    @state = configs[:state]
    @coordinate = configs[:coordinate]
  end

  def validate
    if (0..MAX_COORDINATE).cover?(coordinate)
      state[coordinate] && "A mark already exists at coordinate: #{coordinate}"
    else
      "Coordinate must be between 0 and #{MAX_COORDINATE}"
    end
  end
end
