require 'strscan'

class Builder
  CURSOR = 'X'
  INITIAL_DIRECTION = 0
  DIRECTIONS = [
    [-1, 0], # UP
    [-1, 1],
    [0,  1], # RIGHT
    [1,  1],
    [1,  0], # BOTTOM
    [1, -1],
    [0, -1], # LEFT
    [-1, -1]
  ]

  attr_accessor :grid
  attr_accessor :position
  attr_accessor :direction

  def initialize(map_size)
    @grid = map_size.times.map { (['.'] * map_size) }
    @position = [map_size/2, map_size/2]
    @direction = INITIAL_DIRECTION
    move(*position)
  end
  
  def rt(i)
    (i / 45).times do
      if direction == 7
        @direction = 0
      else
        @direction += 1
      end
    end
  end

  def fd(i)
    i.times do
      move(position[0] + DIRECTIONS[direction][0], position[1] + DIRECTIONS[direction][1])
    end
  end

  def move(x, y)
    grid[x][y] = CURSOR
    @position = [x, y]
  end

  def display
    grid.each { |row| puts row.join(' ') }
  end
end

class Turtle
  attr_accessor :file
  attr_accessor :builder

  def initialize(path)
    @file = File.open(path).read.split("\n")
    @builder = Builder.new(file.shift.to_i)
    parse!
  end
  
  def parse!
    file.each do |line|
      line == "" ? next : analyize(line)
    end
  end

  def analyize(line)
    string = StringScanner.new(line)
    command = string.scan(/\w+/).downcase
    string.skip(/\W/)

    if command =~ /repeat/i
      repeat(string)
    else
      argument = string.scan(/\d+/).to_i
      builder.send(command, argument)
    end
  end

  def repeat(string)
    string.skip(/\W/)
    count = string.scan(/\d+/).to_i
    string.skip(/\W\[\W/)

    commands = []

    while command = string.scan(/\w+\W\d+/)
      commands << command
      string.skip(/\W/)
    end

    count.times do
      commands.each { |c| analyize(c) }
    end
  end
  
  def display
    builder.display
  end
end

parser = Turtle.new('simple.logo')
parser.display

puts "\n\n"

parser = Turtle.new('complex.logo')
parser.display
