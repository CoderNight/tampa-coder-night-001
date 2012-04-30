class Printer
  def initialize(grid)
    @grid = grid
  end

  def print
    output = ''

    size = @grid.size

    1.upto(size) do |y|
      1.upto(size) do |x|

        cell = @grid.retrieve(x,y)
        if cell.marked?
          output << sprintf("x ")
        else
          output << sprintf(". ")
        end
      end
      output[-1] = "\n" 
    end

    output
  end
end
