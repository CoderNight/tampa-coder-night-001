class Turtle

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

  def steps
    return @steps if @steps
    @steps={}
    (0..325).step(45) do |a|
      h= a < 180 ? 1 : -1
      h=0 if a == 0 || a == 180
      v= a > 90 && a < 270 ? 1 : -1
      v=0 if a == 90 || a == 270
      @steps[a] = [h,v]
    end
    @steps
  end

  def command(line)
    (instruction,argument,*rest) = line.split(/ /)
    value=argument.to_i
    rest.shift # remove brackets
    rest.pop
    hashed_commands = Hash[*rest]
    arguments=hashed_commands.keys.map { |a| "#{a} #{hashed_commands[a]}" }
    send(instruction.downcase.to_sym,value,arguments)
  end

  def repeat(number, arguments)
    number.times do |count|
      arguments.each do |line|
        command(line)
      end
    end
  end

  def bk(distance, arguments = nil)
    direction = (@orientation+180)%360
    line direction, distance
  end

  def fd(distance, arguments = nil)
    line @orientation, distance
  end

  def rt(angle, arguments = nil)
    @orientation += angle
    @orientation %= 360
  end

  def lt(angle, arguments = nil)
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
    (horizontal, vertical) = steps[direction]
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
