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

  def initialize(input)
    lines = input.split("\n")
    size = lines.shift
    @grid = Grid.new(size)
    @commands = lines.reject(&:empty?)
    @position = { :x => @grid.size/2, :y => @grid.size/2 }
    @angle = 0
  end

  def tracks
    grid.mark_position(position)
    commands.each do |cmd|
      process_command(cmd)
    end
    grid.to_s
  end

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
    grid.mark_position(position)
  end

  private

  def process_command(cmd)
    action, amount, commands = parse_command(cmd)
    case action
    when 'LT'
      rotate(-amount)
    when 'RT'
      rotate(amount)
    when 'FD'
      amount.times { move }
    when 'BK'
      rotate(180)
      amount.times { move }
      rotate(180)
    when 'REPEAT'
      amount.times do
        commands.each do |cmd|
          process_command(cmd)
        end
      end
    end
  end

  def parse_command(cmd)
    case
    when rotate = cmd.match(/^(LT|RT)\s(\d+)/)
      dir,deg = rotate[1], rotate[2].to_i
      return [dir, deg]
    when move = cmd.match(/^(FD|BK)\s(\d+)/)
      dir,dist = move[1], move[2].to_i
      return [dir, dist]
    when repeat = cmd.match(/^(REPEAT)\s(\d+)\s\[(.*)\]/)
      action = repeat[1]
      amount = repeat[2].to_i
      cmds = extract_commands(repeat[3].strip)
      return ['REPEAT', amount, cmds]
    end
  end

  def extract_commands(str)
    str.scan(/\w+\s\d+/)
  end

end

