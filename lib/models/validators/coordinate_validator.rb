class CoordinateValidator
  MAX_COORDINATE = 8

  def validate(state, coordinate)
    if (0..MAX_COORDINATE).cover?(coordinate)
      state[coordinate] && "A mark already exists at coordinate: #{coordinate}"
    else
      "Coordinate must be between 0 and #{MAX_COORDINATE}"
    end
  end
end
