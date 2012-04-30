require File.dirname(__FILE__) + '/turtle'

class TurtleTracks
  def self.process(args=[])
    raise 'Please supply an input file' if args.empty?

    input = read_input(args[0])
    output = File.open(args[1] || 'turtle_out.txt', 'w')

    process_input(input, output)
  end

  def self.read_input(file)
    begin
      input = File.read(file)
    rescue Errno::ENOENT
      raise 'Input file not found'
    end
    input
  end

  def self.process_input(input, output)
    turtle = Turtle.new(input)
    output.write(turtle.tracks)
  end

end

