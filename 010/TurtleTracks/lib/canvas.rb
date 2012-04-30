module TurtleTracks
  class Canvas
    
    def initialize(size)
      @internal = Array.new(size) {Array.new(size) {'.'}}
    end
    
    def turn_on(x,y)
      @internal[y][x] = 'X'
    end
    
    def turn_off(x,y)
      @internal[y][x] = '.'
    end
    
    def to_s
      @internal.collect{ |row| row.join(' ') }.join("\n")
    end
    
  end
end