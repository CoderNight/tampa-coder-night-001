class Heading

  POSITIONS = 8
  DEGREES = 45.0

  def initialize()
    @direction = 'North' 

    @compass = {
      'North'     => 0,
      'NorthEast' => 1,
      'East'      => 2,
      'SouthEast' => 3,
      'South'     => 4,
      'SouthWest' => 5,
      'West'      => 6,
      'NorthWest' => 7
    }

  end

  def forward 
    @direction
  end

  def reverse
    reverse_index = (@compass[@direction] + POSITIONS / 2) % POSITIONS
    @compass.invert[reverse_index]
  end

  def rotate_right(degrees) 
    rotate(degrees, '+')
  end

  def rotate_left(degrees) 
    rotate(degrees, '-')
  end

  private 

  def rotate(degrees, operator)
    change = degrees / DEGREES
    
    if change.to_i != change
      raise(ArgumentError, "degrees must be evenly divisble by #{DEGREES}")
    end

    index = @compass[@direction]
    eval "index = (index #{operator} change.to_i) % POSITIONS"

    @direction = @compass.invert[index]
  end

end
