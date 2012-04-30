require 'spec_helper'

describe Interpreter do
  before do
    @turtle = double(:turtle)
    @interpreter = Interpreter.new(@turtle)
  end

  describe "#parse" do
    it "moves turtle forward 5" do
      @turtle.should_receive(:forward).with(5)
      @interpreter.parse(Scanner.new('FD 5'))
    end

    it "moves turtle backward 2" do
      @turtle.should_receive(:reverse).with(2)
      @interpreter.parse(Scanner.new('BK 2'))
    end

    it "moves turtle right 90 degrees" do
      @turtle.should_receive(:right).with(90)
      @interpreter.parse(Scanner.new('RT 90'))
    end

    it "moves turtle left 90 degrees" do
      @turtle.should_receive(:left).with(90)
      @interpreter.parse(Scanner.new('LT 90'))
    end

    it "repeats the sequence rt 90 and fd 15 twice" do 
      @turtle.should_receive(:right).with(90).ordered
      @turtle.should_receive(:forward).with(15).ordered
      @turtle.should_receive(:right).with(90).ordered
      @turtle.should_receive(:forward).with(15).ordered
      @interpreter.parse(Scanner.new('REPEAT 2 [ RT 90 FD 15 ]'))
    end

    it "performs a compound command" do
      @turtle.should_receive(:forward).with(2).ordered
      @turtle.should_receive(:right).with(90).ordered
      @turtle.should_receive(:forward).with(15).ordered
      @turtle.should_receive(:right).with(90).ordered
      @turtle.should_receive(:forward).with(15).ordered
      @turtle.should_receive(:reverse).with(2).ordered
      @interpreter.parse(Scanner.new('FD 2 REPEAT 2 [ RT 90 FD 15 ] BK 2'))
    end

    it "performs a nested compound command" do
      @turtle.should_receive(:right).with(90).ordered
      @turtle.should_receive(:reverse).with(2).ordered
      @turtle.should_receive(:reverse).with(2).ordered
      @turtle.should_receive(:right).with(90).ordered
      @turtle.should_receive(:reverse).with(2).ordered
      @turtle.should_receive(:reverse).with(2).ordered
      @interpreter.parse(Scanner.new('REPEAT 2 [ RT 90 REPEAT 2 [ BK 2 ] ]'))
    end
  end

end
