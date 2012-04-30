require 'test/unit'
require_relative '../lib/canvas'

module TurtleTracks
  class TestCanvas < Test::Unit::TestCase
    def test_simple
      canvas = Canvas.new(3)
      assert_equal(". . .\n. . .\n. . .", canvas.to_s)
    end
    
    def test_turn_on_off
      canvas = Canvas.new(3)
      canvas.turn_on(0,0)
      assert_equal("X . .\n. . .\n. . .", canvas.to_s)
      canvas.turn_off(0,0)
      assert_equal(". . .\n. . .\n. . .", canvas.to_s)
      
      canvas.turn_on(1,0)
      assert_equal(". X .\n. . .\n. . .", canvas.to_s)
      canvas.turn_off(1,0)
      assert_equal(". . .\n. . .\n. . .", canvas.to_s)
      
      canvas.turn_on(0,1)
      assert_equal(". . .\nX . .\n. . .", canvas.to_s)
      canvas.turn_off(0,1)
      assert_equal(". . .\n. . .\n. . .", canvas.to_s)
    end
    
  end
  
end