require 'spec_helper'

describe Grid do
  GRIDSIZE = 3

  def Cell; end

  before :each do
    @cell = double(:cell)
    @cell.stub(:is_a?) { |arg| arg == Cell ? true : false }
    @grid = Grid.new(GRIDSIZE)
  end

  describe "#initialize" do
    it "requires an integer for its size" do
      lambda { Grid.new(5.5) }.should raise_error(ArgumentError)
    end

    it "requires an odd integer for its size" do
      lambda { Grid.new(4) }.should raise_error(ArgumentError)
    end

    it "requires an integer >= 3 for its size" do
      lambda { Grid.new(1) }.should raise_error(ArgumentError)
    end
  end
  
  describe "#place/#retrieve" do
    (1..GRIDSIZE).each do |x|
      (1..GRIDSIZE).each do |y|
        it "place a cell at x:#{x} y:#{y} and retrieve it" do
          @grid.place(@cell, x, y)
          @grid.retrieve(x, y).should be @cell
        end
      end
    end

    it 'accepts x and y as Integers only' do
      lambda { @grid.place(@cell, 1, 1.5) }.should raise_error(ArgumentError)
      lambda { @grid.place(1, @cell, 1) }.should raise_error(ArgumentError)
      lambda { @grid.place(@cell, 'foo', 1) }.should raise_error(ArgumentError)
      lambda { @grid.place(@cell, 1, 'foo') }.should raise_error(ArgumentError)
    end

    it 'cannot accept coordinates outside its size' do
      lambda { @grid.place(@cell, 0, 0) }.should raise_error(ArgumentError)
      lambda { @grid.place(@cell, 4, 4) }.should raise_error(ArgumentError)
      lambda { @grid.place(@cell, -1, -1) }.should raise_error(ArgumentError)
    end
  end

  describe "#complete?" do

    it 'returns true if @matrix is fully populated' do
      (1..GRIDSIZE).each do |x|
        (1..GRIDSIZE).each do |y|
          @grid.place(@cell, x, y)
        end
      end
      @grid.complete?.should eql true
    end

    it 'returns false if @matrix is empty' do
      @grid.complete?.should eql false
    end

    it 'returns false if @matrix is not fully populated' do
      (2..GRIDSIZE).each do |x|
        (2..GRIDSIZE).each do |y|
          @grid.place(@cell, x, y)
        end
      end
      @grid.complete?.should eql false 
    end
  end
end
