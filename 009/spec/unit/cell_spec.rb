require 'spec_helper'

describe Cell do
  DIRECTIONS = %w[ North NorthEast East SouthEast South SouthWest West NorthWest ]

  before :each do
    @cell = Cell.new()
  end

  describe "#initialize" do
  end

  describe "#enter" do
    it 'should change to marked once entered' do
      @cell.marked?.should eql false
      @cell.enter()
      @cell.marked?.should eql true
    end
  end

  describe "#set_neighbor" do
    it 'raises ArgumentError if direction is invalid' do
      lambda { @cell.set_neighbor('Nowhere', double()) }.should raise_error(ArgumentError)
    end

    DIRECTIONS.each do |direction|
      it "sets #{direction} neighbor" do
        @cell.set_neighbor(direction, double("#{direction} cell"))
      end
    end
  end

  describe "#get_neighbor" do
    before :each do
      @neighbor = {}
      @cell = Cell.new()

      DIRECTIONS.each do |direction|
        @neighbor[direction] = double("#{direction} cell")
        @cell.set_neighbor(direction, @neighbor[direction])
      end
    end

    it 'raises ArgumentError if direction is invalid' do
      lambda { @cell.get_neighbor('Nowhere') }.should raise_error ArgumentError
    end

    DIRECTIONS.each do |direction|
      it "gets the #{direction} neighbor cell" do
        @cell.get_neighbor(direction).should be @neighbor[direction]
      end
    end

    it 'gets itself if it doesnt have the neighbor requested' do
      cell = Cell.new()
      DIRECTIONS.each do |direction|
        cell.get_neighbor(direction).should be cell
      end
    end
  end
end
