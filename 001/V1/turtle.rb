class Turtle

  def run argv
    argv.each do |filename|
      lines=File.open(filename).readlines
      next if lines.empty?
      self.dimension=lines.shift.to_i
      lines.shift # skip blank line
      lines.each do |line|
        command(line)
      end
    end
  end

  def command line
    (instruction,argument,*rest)=line.split(/ /)
    value=argument.to_i
    case instruction
      when 'FD'
        forward(value)
      when 'RT'
        right(value)
      when 'LT'
        left(value)
      when 'BK'
        backward(value)
      when 'REPEAT'
        rest.shift # remove brackets
        rest.pop
        commands=[]
        while(!rest.empty?) do
          commands << "#{rest.shift} #{rest.shift}"
        end
        repeat(value,commands)
      else
        raise "Unknown command: #{line}"
    end
  end

  def repeat number, commands
    number.times do |count|
      commands.each do |line|
        command(line)
      end
    end
  end

  def backward distance
    direction=(@orientation+180)%360
    line direction, distance
  end

  def forward distance
    line @orientation, distance
  end

  def line direction, distance
    steps={
        0 => [  0, -1 ],
       45 => [  1, -1 ],
       90 => [  1,  0 ],
      135 => [  1,  1 ],
      180 => [  0,  1 ],
      225 => [ -1,  1 ],
      270 => [ -1,  0 ],
      315 => [ -1, -1 ]
    }
    (horizontal, vertical)=steps[direction]
    distance.times do |count|
      @location[0]+=horizontal
      @location[1]+=vertical
      plot(@location)
    end
  end

  def right angle
    @orientation+=angle
    @orientation%=360
  end

  def left angle
    @orientation-=angle
    @orientation%=360
  end

  def clear
    @grid=[]
    return if !@dimension || @dimension == 0
    @dimension.times do |y|
      @grid[y]=[]
      @dimension.times do |x|
        @grid[y][x]='.'
      end
    end
    plot(@location)
  end

  def plot location
    (x,y)=location
    @grid[y][x]='X'
  end

  def output
    out=""
    lines=[]
    @grid.each do |row|
      line=""
      row.each do |column|
        line+="#{column} "
      end
      line+="\n"
      line.rstrip!
      lines << line
    end
    lines.each do |line|
      out+="#{line}\n"
    end
    out
  end

  def dimension= d
    @location=[d/2,d/2]
    @orientation=0
    @dimension=d
    clear
  end

  def dimension
    @dimension
  end

  def orientation= o
    @orientation=o
  end

  def orientation
    @orientation
  end

  def location= l
    @location=l
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
