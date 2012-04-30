class GridBuilder

  def self.populate_grid(grid)
    1.upto(grid.size) do |x|
      1.upto(grid.size) do |y|
        grid.place(Cell.new, x, y)
      end
    end
  end

  def self.initialize_neighbors(grid)

    top_edge    = 1
    left_edge   = 1
    bottom_edge = grid.size
    right_edge  = grid.size

    1.upto grid.size do |x|
      1.upto grid.size do |y|

        cell = grid.retrieve(x,y)

        cell.set_neighbor('North', grid.retrieve(x, y-1)) unless
          y == top_edge

        cell.set_neighbor('NorthEast', grid.retrieve(x+1, y-1)) unless
          x == right_edge or y == top_edge

        cell.set_neighbor('East', grid.retrieve(x+1, y)) unless
          x == right_edge

        cell.set_neighbor('SouthEast', grid.retrieve(x+1, y+1)) unless
          x == right_edge or y == bottom_edge

        cell.set_neighbor('South', grid.retrieve(x, y+1)) unless
          y == bottom_edge 
    
        cell.set_neighbor('SouthWest', grid.retrieve(x-1, y+1)) unless
          x == left_edge or y == bottom_edge

        cell.set_neighbor('West', grid.retrieve(x-1, y)) unless
          x == left_edge

        cell.set_neighbor('NorthWest', grid.retrieve(x-1, y-1)) unless 
          x == left_edge or y == top_edge
      end
    end
  end

end
