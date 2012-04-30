require_relative('../lib/command_parser')
require_relative('../lib/turtle')

ARGV.each do | input |
  open(input) do | io |
    parser = TurtleTracks::CommandParser.new(io)
    turtle = TurtleTracks::Turtle.new
    parser.parse(turtle)
    puts turtle.to_s
  end
end