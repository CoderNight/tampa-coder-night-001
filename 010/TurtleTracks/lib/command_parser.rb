require('stringio')

module TurtleTracks
  class CommandParser
    
    def initialize(input)
      @input = input
      @commands = Commands.new(self)
    end
    
    def parse(turtle)
      enum = @input.each_line
      parse_size(turtle, enum)
      parse_commands(turtle, enum)
    end
    
    def parse_commands(turtle,enum)
      begin
        while true
          line = enum.next.strip
          parse_line(turtle, line) unless line.empty?
        end
      rescue StopIteration
      end
    end
    
    def parse_size(turtle, enum)
      turtle.init_canvas(enum.next.strip.to_i)
    end
    
    def parse_line(turtle, line)
      input = StringIO.new(line)
      command = input.readline(' ').strip.downcase
      @commands.send(command.to_sym, turtle, input)
    end
  end
  
  class Commands
    def initialize(parser)
      @parser=parser
    end
    
    def fd(turtle, input)
      execute(turtle, :move_forward, input)
    end
    
    def rt(turtle, input)
      execute(turtle, :rotate_clockwise, input)
    end
    
    def lt(turtle, input)
      execute(turtle, :rotate_counter, input)
    end
    
    def bk(turtle, input)
      execute(turtle, :move_backward, input)
    end
    
    def execute(turtle, action, input)
      turtle.send(action, input.readline.to_i)
    end
    
    def repeat(turtle, input)
      amount = input.readline(' ').strip.to_i
      commands = extract_commands(input)
      amount.times do
        @parser.parse_commands(turtle,commands.each)
      end
    end
    
    def extract_commands(input)
      rest = input.readline.delete("[]").strip
      commands = []
      enum = rest.each_line(' ')
      begin
        while true
          commands.push("#{enum.next} #{enum.next}")
        end
      rescue StopIteration
      end
      commands
    end
  end
end