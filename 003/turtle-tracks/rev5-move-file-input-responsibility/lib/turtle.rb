require File.dirname(__FILE__) + '/grid'

class Turtle
  attr_accessor :position, :angle
  attr_reader :grid, :commands

  DIRECTIONS = {
    0   => { :x =>  0, :y => -1 },
    45  => { :x =>  1, :y => -1 },
    90  => { :x =>  1, :y =>  0 },
    135 => { :x =>  1, :y =>  1 },
    180 => { :x =>  0, :y =>  1 },
    225 => { :x => -1, :y =>  1 },
    270 => { :x => -1, :y =>  0 },
    315 => { :x => -1, :y => -1 }
  }

  def initialize(canvas_size=100)
    create_canvas(canvas_size)
  end

  def create_canvas(canvas_size=100)
    @grid = Grid.new(canvas_size)
    @position = { :x => @grid.size/2, :y => @grid.size/2 }
    @angle = 0
    mark_position
  end

  def process_commands(commands)
    commands.each do |cmd|
      process_command(cmd)
    end
  end

  def tracks
    grid.to_s
  end

  def mark_position
    grid.mark_position(position)
  end

  def left(degrees)
    rotate(-degrees)
  end
  alias_method 'LT', 'left'

  def right(degrees)
    rotate(degrees)
  end
  alias_method 'RT', 'right'

  def forward(distance)
    distance.times { move }
  end
  alias_method 'FD', 'forward'

  def back(distance)
    left(180)
    distance.times { move }
    right(180)
  end
  alias_method 'BK', 'back'

  def repeat(amount, commands)
    amount.times do
      commands.each do |cmd|
        process_command(cmd)
      end
    end
  end
  alias_method 'REPEAT', 'repeat'

  def rotate(amount)
    # WTF? why can't I use the accessor here?
    # angle += amount #=> undefined method '+' for nil:NilClass
    @angle += amount
    if angle >= 360
      @angle -= 360
    elsif @angle < 0
      @angle += 360
    end
  end

  def move
    position[:x] += DIRECTIONS[angle][:x]
    position[:y] += DIRECTIONS[angle][:y]
    mark_position
  end

  private

  def process_command(cmd)
    action, amount, commands = parse_command(cmd)
    if commands
      send(action, amount, commands)
    else
      send(action, amount)
    end
  end

  def parse_command(cmd)
    match = cmd.match(/^(LT|RT|FD|BK|REPEAT)\s(\d+)\]?(.*)\]?/)
    action, amount, commands = match[1], match[2].to_i, extract_commands(match[3])
    if commands.empty?
      return [action, amount]
    else
      return [action, amount, commands]
    end
  end

  def extract_commands(str)
    str.scan(/\w+\s\d+/)
  end

end

