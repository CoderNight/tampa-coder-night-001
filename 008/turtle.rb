# encoding: UTF-8
#!/usr/bin/env ruby

require 'strscan'

#  ___________________
# < All the way down. >
#  -------------------
#     \                                  ___-------___
#      \                             _-~~             ~~-_
#       \                         _-~                    /~-_
#              /^\__/^\         /~  \                   /    \
#            /|  O|| O|        /      \_______________/        \
#           | |___||__|      /       /                \          \
#           |          \    /      /                    \          \
#           |   (_______) /______/                        \_________ \
#           |         / /         \                      /            \
#            \         \^\\         \                  /               \     /
#              \         ||           \______________/      _-_       //\__//
#                \       ||------_-~~-_ ------------- \ --/~   ~\    || __/
#                  ~-----||====/~     |==================|       |/~~~~~
#                   (_(__/  ./     /                    \_\      \.
#                          (_(___/                         \_____)_)
#
# USAGE: `ruby turtle.rb PATH_TO_INPUT [--png]`
#   Requires at least ruby 1.9, and optionally `chunky_png` for png output.
#
class Turtle
  EMPTY_CELL = 0
  DRAWN_CELL = 1

  # A 2D point representing the position of the cursor.
  attr :position

  # The degree of rotation for the cursor.
  attr :direction

  # A 2D array of "bits" representing our drawing space.
  attr :canvas

  # Create a new Turtle from the given source text. A renderer is not required
  # here, but don't try to render without it (see `Turtle.load`).
  def initialize(source, renderer = nil)
    @renderer = renderer
    stack = Turtle.parse(source)
    stack.each do |command|
      command.execute(self)
    end
  end

  # Set the size of the canvas, fill it with blank cells, center the cursor,
  # orient it up (0), and draw in the initial position.
  def setup_grid(size_x, size_y)
    @position = Vector2D.new(size_x / 2, size_y / 2)
    @direction = 0
    @canvas = []
    size_x.times do |x|
      @canvas[x] = []
      size_y.times do |y|
        @canvas[x][y] = EMPTY_CELL
      end
    end
    draw
  end

  # Move the current position one unit in the current direction.
  def move
    @position = @position + Vector2D.from_angle(direction)
  end

  # Draw in the cell at the current position.
  def draw
    @canvas[@position.x][@position.y] = DRAWN_CELL
  end

  # Move the given number of units in the current direction, drawing at each
  # position.
  def move_and_draw(amount)
    amount.times do
      move
      draw
    end
  end

  # Turn the cursor by the amount given in degrees.
  def rotate(amount)
    @direction = (@direction + amount) % 360
  end

  def render
    @renderer.new(@canvas)
  end

  class << self

    def parse(text)
      input = StringScanner.new(text.strip)
      [].tap do |stack|
        until input.eos?
          # Look for commands we know about and add them to the stack.
          Turtle::Command::LEXICON.each do |pattern, klass|
            if input.scan(pattern)
              command = klass.new(input[1], input[2])
              stack << command
            end
          end
          # Handle EOF, whitespace, or unexpected input.
          unless input.eos? || input.scan(/\s+/)
            token = input.scan_until(/\s/).strip
            raise('Unexpected token: "%s".' % token)
          end
        end
      end
    end

    # Read from a file at the given path and render the turtle. Returns the
    # turtle.
    def load(path, renderer = Renderer::ASCII)
      source = File.read(path)
      turtle = Turtle.new(source, renderer)
      turtle.render
      return turtle
    end
  end

  # Base class for all commands in our grammar.
  class Command
    LEXICON = {}

    attr :value

    def initialize(new_value, block = nil)
      @value = new_value.to_i
    end

    # Execute this command in the context of the given turtle. This method
    # is overriden in each command class.
    def execute(turtle)
      raise('Command "%s" has no implementation to execute.' % self.class)
    end

    # Store a map of the patterns for each token we will use to parse input.
    def self.token(expression)
      LEXICON[expression] = self
    end
  end

  # This is the first line of the input, a lone number describing the size of
  # the canvas. It's always square by the puzzle rules, but given an update 
  # to the syntax, `Turtle` and the renderers should handle odd sizes fine.
  class Grid < Command
    token /^(\d+)/

    def execute(turtle)
      turtle.setup_grid(value, value)
    end
  end

  class Forward < Command
    token /FD (\d+)/

    def execute(turtle)
      turtle.move_and_draw(value)
    end
  end

  class Backward < Command
    token /BK (\d+)/

    def execute(turtle)
      turtle.rotate(180)
      turtle.move_and_draw(value)
      turtle.rotate(180)
    end
  end

  class Rotate < Command

    def initialize(new_value, block = nil)
      super
      unless (value % 45).zero?
        raise('Rotation is limited to 45° increments.')
      end
    end
  end

  class Left < Rotate
    token /LT (\d+)/

    def execute(turtle)
      turtle.rotate(value * -1)
    end
  end

  class Right < Rotate
    token /RT (\d+)/

    def execute(turtle)
      turtle.rotate(value)
    end
  end

  # The REPEAT command is special in that it has it's own stack of commands,
  # like Turtle.
  class Repeat < Command
    token /REPEAT (\d+) \[(.+)\]/

    attr :stack

    def initialize(value, block)
      super
      @stack = Turtle.parse(block)
    end

    def execute(turtle)
      value.times do
        stack.each do |command|
          command.execute(turtle)
        end
      end
    end
  end

  class Vector2D

    attr :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    # Combine 2 vectors
    def +(other_vector)
      new_x = @x + other_vector.x
      new_y = @y + other_vector.y
      Vector2D.new(new_x, new_y)
    end

    # A vector based on the given angle. This new vector can be added to the
    # current position to move in that direction.
    def self.from_angle(direction)
      case direction
        when   0 then new(-1,  0)
        when  45 then new(-1,  1)
        when  90 then new( 0,  1)
        when 135 then new( 1,  1)
        when 180 then new( 1,  0)
        when 225 then new( 1, -1)
        when 270 then new( 0, -1)
        when 315 then new(-1, -1)
        else new(0,0)
      end
    end
  end

  # Pluggable renderers. These only need to initialize with a given canvas.
  module Renderer

    # Renders the basic text output to STDOUT
    class ASCII

      # Characters used to draw the output
      EMPTY_CELL       = '.'
      DRAWN_CELL       = 'X'
      COLUMN_DELIMETER = ' '
      ROW_DELIMETER    = "\n"

      # Initialize with a 2D array of 0's and 1's and draw.
      def initialize(canvas)
        output = canvas.map { |row|
          row.map { |col|
            col == Turtle::EMPTY_CELL ? EMPTY_CELL : DRAWN_CELL
          }.join(COLUMN_DELIMETER)
        }.join(ROW_DELIMETER)
        $>.puts(output)
      end
    end

    # Render a PNG image. Requires the `chunky_png` gem to be installed.
    class PNG
      begin
        require 'chunky_png'
      rescue LoadError
        # Don't print anything here, we don't want to muck with the output
        # for the ascii renderer.
      end

      EMPTY_CELL = :black
      DRAWN_CELL = :limegreen

      def initialize(canvas)
        if Object.const_defined?("ChunkyPNG")
          size_x = canvas.size
          size_y = canvas[0].size
          png = ChunkyPNG::Image.new(size_x, size_y,
            ChunkyPNG::Color(EMPTY_CELL))
          size_x.times do |x|
            size_y.times do |y|
              if canvas[y][x] == Turtle::DRAWN_CELL
                png[x,y] = ChunkyPNG::Color(DRAWN_CELL)
              end
            end
          end
          png.save('turtle.png')
          if RUBY_PLATFORM =~ /darwin/
            exec('qlmanage -p turtle.png >& /dev/null')
          end
        else
          $stderr.puts('"chunky_png" not found. `gem install chunky_png`.')
          exit(1)
        end
      end
    end
  end
end

if $0 == __FILE__
  unless ARGV[0].nil?
    renderer = case ARGV[1]
    when /--png/
      Turtle::Renderer::PNG
    # when /--html/ or what else?
    else
      Turtle::Renderer::ASCII
    end
    Turtle.load(ARGV[0], renderer)
  else
    print "USAGE: ruby turtle.rb PATH_TO_INPUT [--png]"
  end
end
