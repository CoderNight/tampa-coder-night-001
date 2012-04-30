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
    rows.map {|row| row.join() }.join("\n") + "\n"
  end

  private

  def create_grid
    Array.new(size) { Array.new(size) { |i| i == size-1 ? '.' : '. ' } }
  end

end
