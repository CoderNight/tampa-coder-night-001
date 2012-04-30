require_relative 'turtle'

describe Canvas do

  before { subject.size = 3 }

  it "defines a canvas of a given size" do
    subject.size.should == 3
  end

  it "adds points to the points array" do
    subject.add(2, 2)
    subject.points.should include([2, 2])
  end

  it "defines the last point added" do
    subject.add(2, 1)
    subject.last.should == [2, 1]
  end

  it "prevents points from being added out of bounds" do
    expect { subject.add(5, 5) }.to raise_error(/exceeds the canvas bounds/)
  end

  it "creates a center point when the canvas is sized" do
    subject.points.size.should == 1
    subject.points.should include([1, 1])
  end

  it "determines whether the points array contains a point" do
    subject.contains?(1, 1).should be_true
    subject.contains?(2, 0).should be_false
    subject.add(2, 0)
    subject.contains?(2, 0).should be_true
  end

  it "creates a hash representation of points keyed by y" do
    subject.add(1,2)
    subject.add(2,2)
    subject.to_h[2].should == [1,2]
  end

  it "prints the canvas" do
    subject.add(0, 2).add(1, 2).add(2, 1)
    expected = ". . .\n. X X\nX X ."
    subject.to_s.should == expected
  end

end

describe Turtle do

  subject { Turtle.new(7) }

  it "has a canvas" do
    subject.canvas.should_not be_nil
    subject.canvas.is_a?(Canvas).should be_true
  end

  describe "orientation" do

    it "has an orientation attribute initialized to 0" do
      subject.orientation.should == 0
    end

    it "rotates the orientation clockwise" do
      subject.rotate(180).should == 180
      subject.rotate(225).should == 45
    end

    it "rotates the orientation counter-clockwise" do
      subject.rotate(-90).should == 270
      subject.rotate(-360).should == 270
    end

    it "turns right" do
      subject.right(270).should == 270 
    end
    
    it "turns left" do
      subject.left(270).should == 90
    end

  end

  describe "movement" do

    it "calculates a new endpoint for a given unit of movement" do
      subject.endpoint(2).should == [3, 1]
    end

    it "steps one unit" do
      subject.step([3, 3], [3, 1]).should == [3, 2]
    end

    it "moves starting in the default orientation" do
      subject.move(1)
      points = [[3, 3], [3, 2]]
      points.each { |x, y| subject.canvas.contains?(x, y).should be_true }
    end

    it "moves backward" do
      subject.move(-2)
      points = [[3, 3], [3, 4], [3, 5]]
      points.each { |x, y| subject.canvas.contains?(x, y).should be_true }
    end

    it "moves when in 45 degree orientation" do
      subject.rotate(45)
      subject.move(2)
      points = [[3, 3], [4, 2], [5, 1]]
      points.each { |x, y| subject.canvas.contains?(x, y).should be_true } 
    end

    it "moves when in 270 degree orientation" do
      subject.rotate(270)
      subject.move(2)
      points = [[3, 3], [2, 3], [1, 3]]
      points.each { |x, y| subject.canvas.contains?(x, y).should be_true } 
    end

  end #movement

  describe "commands" do

    it "moves forward with the FD command" do
      subject.process("FD 2")
      subject.canvas.contains?(3, 1).should be_true
    end

    it "moves backward with the BK command" do
      subject.process("BK 2")
      subject.canvas.contains?(3, 5).should be_true
    end

    it "turns right with the RT command" do
      subject.process("RT 90")
      subject.orientation.should == 90
    end

    it "turns left with the LT command" do
      subject.process("LT 90")
      subject.orientation.should == 270
    end

    it "repeats commands" do
      subject.process("REPEAT 2 [ RT 90 FD 2 ]")
      subject.canvas.points.size.should == 5
      subject.canvas.contains?(5, 5).should be_true
    end
  end
end
