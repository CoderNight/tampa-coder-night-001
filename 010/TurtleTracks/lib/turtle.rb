require_relative('canvas')

module TurtleTracks
  class Turtle
    def initialize
      @direction = 0
    end
    
    def init_canvas(size)
      @canvas = Canvas.new(size)
      @x = @y = size / 2
      @canvas.turn_on(@x,@y)
    end
    
    def move_forward(amount)
      move(amount, :+)
    end
    
    def move_backward(amount)
      move(amount, :-)
    end
    
    def move(amount, polarity)
      byX, byY = translate_direction
      amount.times do
        @x, @y = @x.send(polarity,byX), @y.send(polarity, byY)
        @canvas.turn_on(@x,@y)
      end
    end
    
    def translate_direction
      case @direction
      when 0
        [0,-1]
      when 45
        [1,-1]
      when 90
        [1,0]
      when 135
        [1,1]
      when 180
        [0,1]
      when 225
        [-1,1]
      when 270
        [-1,0]
      when 315
        [-1,-1]
      else
        raise "incorrect direction: #{@direction}"
      end
    end
    
    def rotate_clockwise(degrees)
      @direction += degrees
      @direction = check_degrees(@direction)
    end
    
    def rotate_counter(degrees)
      @direction -= degrees
      @direction = check_degrees(@direction)
    end
    
    def check_degrees(degrees)
      return degrees + 360 if degrees < 0
      return degrees - 360 if degrees > 360
      degrees
    end
    
    def to_s
      @canvas.to_s
    end
    
  end
end