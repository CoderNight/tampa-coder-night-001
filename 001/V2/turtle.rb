class Turtle
  STEPS = {
      0 => [  0, -1 ],
     45 => [  1, -1 ],
     90 => [  1,  0 ],
    135 => [  1,  1 ],
    180 => [  0,  1 ],
    225 => [ -1,  1 ],
    270 => [ -1,  0 ],
    315 => [ -1, -1 ]
  }

  COMMANDS = {
    FD: :forward,
    RT: :right,
    LT: :left,
    BK: :backward,
    REPEAT: :repeat
  }

  def run(argv)
    argv.each do |filename|
      lines = File.open(filename).readlines
      next if lines.empty?
      self.dimension = lines.shift.to_i
      lines.shift # skip blank line
      lines.each do |line|
        command(line)
      end
    end
  end

  def command(line)
    (instruction,argument,*rest) = line.split(/ /)
    value=argument.to_i
    rest.shift # remove brackets
    rest.pop
    hashed_commands = Hash[*rest]
    arguments=hashed_commands.keys.map { |a| "#{a} #{hashed_commands[a]}" }
    send(COMMANDS[instruction.to_sym],value,arguments)
  end

  def repeat(number, arguments)
    number.times do |count|
      arguments.each do |line|
        command(line)
      end
    end
  end

  def backward(distance, arguments = nil)
    direction = (@orientation+180)%360
    line direction, distance
  end

  def forward(distance, arguments = nil)
    line @orientation, distance
  end

  def right(angle, arguments = nil)
    @orientation += angle
    @orientation %= 360
  end

  def left(angle, arguments = nil)
    @orientation -= angle
    @orientation %= 360
  end

  def clear
    @grid = []
    return if !@dimension || @dimension == 0
    @dimension.times do |y|
      @grid[y] = []
      @dimension.times do |x|
        @grid[y][x] = '.'
      end
    end
    plot(@location)
  end

  def plot(location)
    (x,y) = location
    @grid[y][x] = 'X'
  end

  def line(direction, distance)
    (horizontal, vertical) = STEPS[direction]
    distance.times do |count|
      @location[0] += horizontal
      @location[1] += vertical
      plot(@location)
    end
  end


  def output
    work = @grid
    work.map { |row| row.join(" ") }.join("\n") + "\n"
  end

  def dimension=(d)
    @location = [d/2,d/2]
    @orientation = 0
    @dimension = d
    clear
  end

  def dimension
    @dimension
  end

  def orientation=(o)
    @orientation = o
  end

  def orientation
    @orientation
  end

  def location=(l)
    @location =l
  end

  def location
    @location
  end

end

if __FILE__ == $0
  turtle=Turtle.new
  turtle.run(ARGV)
  puts turtle.output
end
