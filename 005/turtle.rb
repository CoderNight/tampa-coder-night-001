# encoding: UTF-8
require 'set'

class Turtle
  def initialize(grid_size, x, y, code)
    @grid_size = grid_size
    @code      = code
    @angle     = 0
    @places    = Set.new

    visit(x,y)
  end

  # Logo commands

  def lt(angle)
    change_angle(-angle)
  end

  def rt(angle)
    change_angle(angle)
  end

  def bk(steps)
    walk_steps(steps, backwards_offsets)
  end

  def fd(steps)
    walk_steps(steps, forward_offsets)
  end

  def repeat(count, proc)
    count.times { proc.call }
  end

  # Helper methods below

  def change_angle(increment)
    @angle = (@angle + increment) % 360
  end

  def visited?(x,y)
    @places.include?(coordinate_to_key(x,y))
  end

  def visit(x,y)
    @x, @y = x ,y
    @places << coordinate_to_key(x,y)
  end

  def walk_steps(steps, offset)
    steps.times { visit(@x + offset[0], @y + offset[1]) }
  end

  def run
    instance_eval(@code)
  end

  def forward_offsets
    OFFSETS[@angle]
  end

  def backwards_offsets
    forward_offsets.map { |offset| -1 * offset }
  end

  def coordinate_to_key(x,y)
    # Timings below are for Ruby 1.9.3-p125

    # math method => 0.897s
    x * (@grid_size + 1 ) + y

    # array method => 2.382s
    # [x,y]

    # hash method => 4.460s
    # {:x => x, :y => y}

    # string method => 2.222s
    # "#{x},#{y}"
  end

  OFFSETS = {   0 => [ 0, -1],
               45 => [+1, -1],
               90 => [+1,  0],
              135 => [+1, +1],
              180 => [ 0, +1],
              225 => [-1, +1],
              270 => [-1,  0],
              315 => [-1, -1] }
end

class LogoToRuby
  def self.translate(io)
    # This will make all the commands into Ruby compatible syntax
    io.readlines.join.downcase.
                      # Turns BK nn
                      # into  bk nn;
                      gsub(/ [a-z]{2} \d+/) { |statement| "#{statement};" }.
                      # Turn REPEAT nn [ ... ]
                      # into repeat nn , proc { ... }
                      gsub("[",", proc {").gsub("]","}")
  end
end

grid_size = ARGF.readline.to_i
ARGF.readline

center = (grid_size - 1)/2
turtle = Turtle.new(grid_size, center, center, LogoToRuby.translate(ARGF))
turtle.run

grid_size.times do |y|
  # The following is about 200ms faster for the complex example
  # line = Array.new(grid_size,'.')
  # grid_size.times.each { |x| line[x] = "X" if turtle.visited?(x,y) }
  # puts line.join(" ")

  puts grid_size.times.map { |x| turtle.visited?(x,y) ? "X" : "." }.join(" ")
end
