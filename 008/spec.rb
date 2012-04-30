# encoding: UTF-8

require 'minitest/autorun'

require_relative 'turtle'

describe Turtle do

  it "renders the correct ASCII output" do
    -> { Turtle.load("files/simple.logo") }.must_output File.read("files/simple_out.txt")
  end

  it "sets the cursor's initial position" do
    turtle = Turtle.new("7")
    turtle.position.x.must_equal 3
    turtle.position.y.must_equal 3
  end

  it "draws the initial position" do
    Turtle.new("5").canvas[2][2].must_equal Turtle::DRAWN_CELL
  end

  it "creates the canvas appropriately" do
    turtle = Turtle.new("3")
    turtle.canvas.must_equal [
      [0, 0, 0],
      [0, 1, 0],
      [0, 0, 0]
    ]
  end

  it "can move and draw" do
    turtle = Turtle.new("3")
    turtle.move_and_draw(1)
    turtle.canvas.must_equal [
      [0, 1, 0],
      [0, 1, 0],
      [0, 0, 0]
    ]
  end

  it "can draw backward" do
    turtle = Turtle.new("3 BK 1")
    turtle.canvas.must_equal [
      [0, 0, 0],
      [0, 1, 0],
      [0, 1, 0]
    ]
  end

  it "can rotate right" do
    turtle = Turtle.new("1 RT 45 RT 45")
    turtle.direction.must_equal 90
  end

  it "can rotate left" do
    turtle = Turtle.new("1 LT 90")
    turtle.direction.must_equal 270
  end

  it "can rotate full circle" do
    turtle = Turtle.new("1 RT 315 RT 90")
    turtle.direction.must_equal 45
  end

  it "restricts angles to 45° increments" do
    -> { Turtle.new("1 RT 42") }.must_raise RuntimeError
  end

  it "parses a simple command" do
    command = Turtle.parse("FD 42")[0]
    command.must_be_instance_of Turtle::Forward
    command.value.must_equal 42
  end

  it "parses the size" do
    command = Turtle.parse("11 RT 90")[0]
    command.must_be_instance_of Turtle::Grid
    command.value.must_equal 11
  end

  it "parses a repeat block" do
    command = Turtle.parse("REPEAT 2 [ RT 45 FD 5 ]")[0]
    command.must_be_instance_of Turtle::Repeat
    command.value.must_equal 2
    command.stack.wont_be_empty
    command.stack[0].must_be_instance_of Turtle::Right
    command.stack[0].value.must_equal 45
    command.stack[1].must_be_instance_of Turtle::Forward
    command.stack[1].value.must_equal 5
  end

  it "raises an exception on garbage" do
    -> { Turtle.parse("RT 45 BANANAS! FD 5") }.must_raise(RuntimeError)
  end

  it "can combine vectors" do
    v1 = Turtle::Vector2D.new(1,2)
    v2 = Turtle::Vector2D.new(3,-4)
    v3 = (v1 + v2)

    v3.x.must_equal 4
    v3.y.must_equal -2
  end
end
