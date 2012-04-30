class ::Array
  def x
    self[0] if any? 
  end

  def y
    self[1] if size > 0  
  end
end

class Canvas
  attr_reader :size, :points

  def initialize(size=nil)
    @points = [] 
    self.size = size || 0
  end

  def size=(s)
    @size = s
    center_pt = s / 2
    add(center_pt, center_pt) if s > 0
  end

  def add(x, y)
    raise "Point [#{x},#{y}] exceeds the canvas bounds" if x > @size || y > @size
    @points << [x, y] 
    self
  end

  def last
    @points.last 
  end

  def contains?(x, y)
    @points.include?([x, y])
  end

  # Hash keyed by y to speed to_s
  def to_h
    @points.inject({}) { |h, pt| (h[pt.y] ? h[pt.y] << pt.x : h[pt.y] = [pt.x]); h } 
  end

  def to_s
    s = ''
    y_hash = self.to_h
    (0...size).each { |y| chars = Array.new(size, '.'); y_hash[y].each { |x| chars[x] = 'X' } if y_hash[y]; s << chars.join(' ') + "\n" }; s.chomp
  end

end

class Turtle

  attr_reader :canvas, :orientation

  def initialize(size=nil)
    @canvas       = Canvas.new(size)
    @orientation  = 0
  end

  def rotate(degrees)
    @orientation += degrees 
    @orientation = @orientation % 360
    @orientation
  end

  def size=(s)
    @canvas.size = s 
  end

  def right(degrees)
    rotate(degrees) 
  end

  def left(degrees)
    rotate(degrees * -1) 
  end

  def endpoint_x(units)
    return @canvas.last.x if @orientation == 0 || @orientation == 180 
    ((@orientation < 180 ? 1 : -1) * units) + @canvas.last.x
  end

  def endpoint_y(units)
    return @canvas.last.y if @orientation == 90 || @orientation == 270
    ((@orientation > 270 || @orientation < 90  ? -1 : 1) * units) + @canvas.last.y
  end

  def endpoint(units)
    [endpoint_x(units), endpoint_y(units)]
  end

  def step_axis(current, target)
    return current if current == target 
    current + (target > current ? 1 : -1)
  end

  def step(current, target)
    new_x = step_axis(current.x, target.x)
    new_y = step_axis(current.y, target.y)
    [new_x, new_y]
  end

  def move(units)
    move_to = endpoint(units)
    @canvas.add(*step(@canvas.last, move_to)) until(@canvas.last == move_to) 
  end

  def to_s
    @canvas.to_s 
  end

  # Command aliases
  alias :fd :move
  alias :rt :right
  alias :lt :left

  def bk(units)
    move(units * -1)
  end

  def process_cmd(str)
    method, arg = str.split 
    execute(method, arg)
  end

  def execute(method, arg)
    self.send(method.downcase, arg.to_i)
  end

  def split_cmds(str)
    parts = str.strip.split 
    (0...(parts.size / 2)).inject([]) { |arr, idx| arr << [parts[idx * 2], parts[(idx * 2) + 1]]; arr }
  end

  def repeat(line)
    outer, inner = line.gsub(/]/,'').split('[')
    commands = split_cmds(inner)
    outer.gsub(/REPEAT\ /,'').to_i.times { commands.each { |method, arg| execute(method, arg) } }
  end

  def process(str)
    str.split("\n").each { |line| (line =~ /REPEAT/ ? repeat(line) : process_cmd(line)) } 
  end

end

t = Turtle.new

# Usage: cat afile.logo | ruby turtle.rb
ARGF.each_with_index do |line, idx|
  break if idx == 0 && line.to_i == 0 #i.e., if rspec
  t.canvas.size = line.to_i if idx == 0
  t.process(line) if idx > 1
end

puts t

