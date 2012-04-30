class Turtle
  def initialize(cell, heading)
    @heading = heading
    @cell = cell
    @cell.enter()
  end

  def forward(moves)
    raise ArgumentError if moves < 1 or moves.to_i != moves 
    
    (1..moves).each do
      @cell = @cell.get_neighbor(@heading.forward())
      @cell.enter()
    end
  end

  def reverse(moves)
    raise ArgumentError if moves < 1 or moves.to_i != moves

    (1..moves).each do
      @cell = @cell.get_neighbor(@heading.reverse())
      @cell.enter()
    end
  end

  def right(degrees)
    @heading.rotate_right(degrees)
  end

  def left(degrees)
    @heading.rotate_left(degrees)
  end
end
