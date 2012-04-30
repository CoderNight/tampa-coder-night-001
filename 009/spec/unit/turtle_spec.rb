require 'spec_helper'

describe Turtle do
  before do
    @cell = double(:cell).as_null_object
    @heading = double(:heading).as_null_object
    @neighbor_cell = double(:neighbor_cell).as_null_object
    @neighbor_cell2 = double(:neighbor_cell2).as_null_object

    @turtle = Turtle.new(@cell, @heading)
  end

  describe '#initialize' do
    it 'enters @cell' do
      @cell.should_receive(:enter)
      Turtle.new(@cell, @heading)
    end
  end

  { :forward => 'East', :reverse => 'West' }.each do |method, direction|

    describe "##{method}" do

      it 'with non-integer raises ArgumentError' do
        lambda { @turtle.send(method, 1.2) }.should raise_error(ArgumentError)
      end

      it 'with 0 or less raises ArgumentError' do
        lambda { @turtle.send(method, 0) }.should raise_error(ArgumentError)
      end

      it "with 1 asks @cell for #{direction} neighbor and enters it" do
        @heading.should_receive(method).and_return(direction)

        @neighbor_cell.should_receive(:enter)
        @cell.should_receive(:get_neighbor).and_return(@neighbor_cell)

        @turtle.send(method, 1)
      end

      it "with 2 asks @cell for #{direction} neighbor, enters it and repeats" do 
        @heading.should_receive(method).twice.and_return(direction)

        @neighbor_cell.should_receive(:enter)
        @cell.should_receive(:get_neighbor).and_return(@neighbor_cell)

        @neighbor_cell2.should_receive(:enter)
        @neighbor_cell.should_receive(:get_neighbor).and_return(@neighbor_cell2)

        @turtle.send(method, 2)
      end
    end
  end

  describe '#right' do
    it "with 90 tells its @heading to turn right 90" do
      @heading.should_receive(:rotate_right).with(90)
      @turtle.right(90)
    end 
  end

  describe '#left' do
    it "with 90 tells its @heading to turn left 90" do
      @heading.should_receive(:rotate_left).with(90)
      @turtle.left(90)
    end
  end
end
