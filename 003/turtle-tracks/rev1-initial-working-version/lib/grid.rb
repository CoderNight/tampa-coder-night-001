class Grid
  attr_reader :rows, :size

  def initialize(size=nil)
    raise 'Missing size parameter' if size.nil?
    @size = size.to_i
    @rows = create_grid
  end

  def mark_position(position)
    if rows[position[:y]] && rows[position[:y]][position[:x]]
      if position[:x] == @size - 1
        rows[position[:y]][position[:x]] = 'X'
      else
        rows[position[:y]][position[:x]] = 'X '
      end
    end
  end

  def to_s
    str = ""
    rows.each do |row|
      row.each do |col|
        str += col
      end
      str += "\n"
    end
    str
  end

  private

  def create_grid
    rows = []
    (0..size-1).each do |i|
      rows[i] = []
      (0..size-1).each do |j|
        rows[i][j] = '. '
      end
      rows[i][-1] ='.'
    end
    rows
  end

end
