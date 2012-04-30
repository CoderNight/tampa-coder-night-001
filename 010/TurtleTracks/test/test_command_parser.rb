require 'test/unit'
require 'stringio'
require_relative '../lib/command_parser'

module TurtleTracks
  class TestCommandParser < Test::Unit::TestCase
    def test_example
      input = StringIO.new("11\n\nRT 90\nFD 5\nRT 135\nFD 5")
      parser = CommandParser.new(input)
      turtle = MockTurtle.new
      commands = parser.parse(turtle)
      
      assert_equal(11, turtle.canvas_size)
      assert_equal(225, turtle.rotations)
      assert_equal(10, turtle.moves)
    end
    
    def test_repeat
      input = StringIO.new("11\n\nREPEAT 2 [ RT 90 FD 15 ]\n")
      parser = CommandParser.new(input)
      turtle = MockTurtle.new
      commands = parser.parse(turtle)
      
      assert_equal(180, turtle.rotations)
      assert_equal(30, turtle.moves)
    end
    
    def test_end_to_end_simple
      input = StringIO.new("11\n\nRT 90\nFD 5\nRT 135\nFD 5")
      parser = CommandParser.new(input)
      turtle = Turtle.new
      commands = parser.parse(turtle)
      
      expected=<<CANVAS
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X X X X X X
. . . . . . . . . X .
. . . . . . . . X . .
. . . . . . . X . . .
. . . . . . X . . . .
. . . . . X . . . . .
CANVAS
      assert_equal(expected.strip,turtle.to_s)
    end
    
  end
  
  class MockTurtle
    attr_accessor :canvas_size,:moves,:rotations
    
    def initialize
      @moves = 0
      @rotations = 0
    end
    
    def init_canvas(size)
      @canvas_size = size
    end
    
    def move_forward(amount)
      @moves = @moves + amount
    end
    
    def move_backward(amount)
      @moves = @moves - amount
    end
    
    def rotate_clockwise(degrees)
      @rotations = @rotations + degrees
    end
    
    def rotate_counter(degrees)
      @reotation = @rotations - degrees
    end
  end
end