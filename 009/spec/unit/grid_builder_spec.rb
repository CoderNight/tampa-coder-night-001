require 'spec_helper'

describe GridBuilder do

  describe "#populate_grid" do
    it "creates a cell on each point on the grid" do
      grid = Grid.new(3)
      grid.complete?.should eql false
      GridBuilder.populate_grid(grid)
      grid.complete?.should eql true
    end
  end

  describe "#initialize_neighbors" do
    def test_neighbor(direction, grid, expected)
      expected.each do |point| 
        cell_x = point[0][0] 
        cell_y = point[0][1] 
        neighbor_x = point[1][0]
        neighbor_y = point[1][1]

        cell = grid.retrieve(cell_x, cell_y)
        cell.get_neighbor(direction).should be @grid.retrieve(neighbor_x, neighbor_y)
      end
    end

    before do
      @grid = Grid.new(3)
      GridBuilder.populate_grid(@grid)
      GridBuilder.initialize_neighbors(@grid)
    end

   
    # [1,1] [2,1] [3,1]
    # [1,2] [2,2] [3,2]
    # [1,3] [2,3] [3,3] 
    
    it "North" do
      test_neighbor('North', @grid,
                    [[[1,1], [1,1]], [[2,1], [2,1]], [[3,1], [3,1]],
                     [[1,2], [1,1]], [[2,2], [2,1]], [[3,2], [3,1]],
                     [[1,3], [1,2]], [[2,3], [2,2]], [[3,3], [3,2]]])
    end

    it "NorthEast" do
      test_neighbor('NorthEast', @grid,
                    [ [[1,1], [1,1]], [[2,1], [2,1]], [[3,1], [3,1]],
                      [[1,2], [2,1]], [[2,2], [3,1]], [[3,2], [3,2]],
                      [[1,3], [2,2]], [[2,3], [3,2]], [[3,3], [3,3]]])
    end

    it "East" do
      test_neighbor('East', @grid,
                    [ [[1,1], [2,1]], [[2,1], [3,1]], [[3,1], [3,1]],
                      [[1,2], [2,2]], [[2,2], [3,2]], [[3,2], [3,2]],
                      [[1,3], [2,3]], [[2,3], [3,3]], [[3,3], [3,3]]])
    end

    it "SouthEast" do
      test_neighbor('SouthEast', @grid,
                    [ [[1,1], [2,2]], [[2,1], [3,2]], [[3,1], [3,1]],
                      [[1,2], [2,3]], [[2,2], [3,3]], [[3,2], [3,2]],
                      [[1,3], [1,3]], [[2,3], [2,3]], [[3,3], [3,3]]])
    end

    it "South" do
      test_neighbor('South', @grid,
                    [[[1,1], [1,2]], [[2,1], [2,2]], [[3,1], [3,2]],
                     [[1,2], [1,3]], [[2,2], [2,3]], [[3,2], [3,3]],
                     [[1,3], [1,3]], [[2,3], [2,3]], [[3,3], [3,3]]])
    end

    it "SouthWest" do
      test_neighbor('SouthWest', @grid,
                    [[[1,1], [1,1]], [[2,1], [1,2]], [[3,1], [2,2]],
                     [[1,2], [1,2]], [[2,2], [1,3]], [[3,2], [2,3]],
                     [[1,3], [1,3]], [[2,3], [2,3]], [[3,3], [3,3]]])
    end

    it "West" do
      test_neighbor('West', @grid,
                    [[[1,1], [1,1]], [[2,1], [1,1]], [[3,1], [2,1]],
                     [[1,2], [1,2]], [[2,2], [1,2]], [[3,2], [2,2]],
                     [[1,3], [1,3]], [[2,3], [1,3]], [[3,3], [2,3]]])
    end

    it "NorthWest" do
      test_neighbor('NorthWest', @grid,
                    [[[1,1], [1,1]], [[2,1], [2,1]], [[3,1], [3,1]],
                     [[1,2], [1,2]], [[2,2], [1,1]], [[3,2], [2,1]],
                     [[1,3], [1,3]], [[2,3], [1,2]], [[3,3], [2,2]]])
    end

  end
end

