require 'test/unit'
require_relative '../lib/turtle'

module TurtleTracks
  class TestTurtle < Test::Unit::TestCase
    def test_simple
      turtle = Turtle.new()
      turtle.init_canvas(3)
      assert_equal(". . .\n. X .\n. . .", turtle.to_s)
    end
    
    def test_move
      turtle = Turtle.new()
      turtle.init_canvas(3)
      turtle.rotate_clockwise(90)
      turtle.move_forward(1)
      assert_equal(". . .\n. X X\n. . .", turtle.to_s)
    end
    
  end
  
end