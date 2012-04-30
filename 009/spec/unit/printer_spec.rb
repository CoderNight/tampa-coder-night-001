require 'spec_helper'

describe Printer do
  before do
  end

  describe '#print' do
    it 'prints a totally marked grid' do
      @cell = double(:cell)
      @cell.should_receive(:marked?).exactly(9).times.and_return(true)

      @grid = double(:grid)
      @grid.should_receive(:size).and_return(3)
      @grid.should_receive(:retrieve).exactly(9).times.and_return(@cell)

      @printer = Printer.new(@grid)

      @printer.print.should eql <<-EOF.gsub(/^\s*/, '')
      x x x
      x x x
      x x x
      EOF
    end

    it 'prints an L grid' do
      @cell = double(:cell)
      @cell.should_receive(:marked?).and_return(true)
      @cell.should_receive(:marked?).and_return(false)
      @cell.should_receive(:marked?).and_return(false)
      @cell.should_receive(:marked?).and_return(true)
      @cell.should_receive(:marked?).and_return(false)
      @cell.should_receive(:marked?).and_return(false)
      @cell.should_receive(:marked?).and_return(true)
      @cell.should_receive(:marked?).and_return(true)
      @cell.should_receive(:marked?).and_return(true)

      @grid = double(:grid)
      @grid.should_receive(:size).and_return(3)
      @grid.should_receive(:retrieve).exactly(9).times.and_return(@cell)

      @printer = Printer.new(@grid)

      @printer.print.should eql <<-EOF.gsub(/^\s*/, '')
      x . .
      x . .
      x x x
      EOF
    end

  end
end
