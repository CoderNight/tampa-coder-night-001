class Grid
  attr_accessor :size

  def initialize(size)
    raise ArgumentError if size.to_i != size or size % 2 == 0 or size < 3
    @size = size
    @matrix = []
    (0..@size-1).each do |x| 
      @matrix[x] = []
      (0..@size-1).each { |point| @matrix[x][point] = nil }
    end 

  end

  def place(cell, x, y)
    raise ArgumentError unless x.is_a? Fixnum and y.is_a? Fixnum
    raise ArgumentError unless x.to_i == x and y.to_i == y
    raise ArgumentError if x > @size or y > @size
    raise ArgumentError if x < 1 or y <  1
    @matrix[x-1][y-1] = cell
  end

  def retrieve(x, y)
    raise ArgumentError if x > @size or y > @size
    @matrix[x-1][y-1]
  end

  def complete?
    @matrix.each do |row|
      return false if row.empty? 
      row.each do |point|
        return false unless point.is_a? Cell
      end
    end
    true
  end
end
