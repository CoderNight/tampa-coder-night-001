class Cell
  COMPASS = {
    'North'     => 0,
    'NorthEast' => 1,
    'East'      => 2,
    'SouthEast' => 3,
    'South'     => 4,
    'SouthWest' => 5,
    'West'      => 6,
    'NorthWest' => 7 
  }

  def initialize
    @marked = false
    @neighbor = {}
  end

  def marked?
    @marked
  end

  def enter
    @marked = true
  end

  def set_neighbor(position, neighbor_cell)
    raise ArgumentError unless COMPASS.has_key? position
    @neighbor[position] = neighbor_cell
  end

  def get_neighbor(position)
    raise ArgumentError unless COMPASS.has_key? position
    @neighbor[position] || self
  end

end
