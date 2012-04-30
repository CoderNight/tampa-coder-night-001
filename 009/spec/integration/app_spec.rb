require "spec_helper"

describe "Application" do
  def execute(lines)
    size = lines.shift.to_i
    commands = lines.join(' ') 

    middle_point = ((size - 1) / 2) + 1

    grid = Grid.new(size.to_i)
    GridBuilder.populate_grid(grid)
    GridBuilder.initialize_neighbors(grid)

    turtle = Turtle.new(grid.retrieve(middle_point, middle_point), Heading.new())

    scanner = Scanner.new(commands)

    interpreter = Interpreter.new(turtle).parse(scanner)

    Printer.new(grid).print
  end

  it "generates output for simple logo file" do
    expected_output = IO.readlines("spec/data/simple.expected").join
    execute(IO.readlines("spec/data/simple.logo")).should eql expected_output
  end

  it "generates output for a complex logo file" do
    expected_output = IO.readlines("spec/data/complex.expected").join
    execute(IO.readlines("spec/data/complex.logo")).should eql expected_output
  end
end
