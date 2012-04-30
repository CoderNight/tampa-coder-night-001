require 'turtle'

describe "9-turtle-tracks" do
  let(:turtle) { Turtle.new }
  let(:argv) { ['filename'] }

  it "takes an input command filename array argument" do
    file=stub
    file.stub!(:readlines).and_return([])
    File.stub!(:open).and_return(file)
    turtle.run(argv)
  end

  describe "reads an input file" do

    it "reads a dimension of 11" do
      file=stub
      file.stub!(:readlines).and_return(['11'])
      File.stub!(:open).and_return(file)
      turtle.should_receive(:dimension=).with(11)
      turtle.run(argv)
    end

    it "reads a dimension of 13" do
      file=stub
      file.stub!(:readlines).and_return(['13'])
      File.stub!(:open).and_return(file)
      turtle.should_receive(:dimension=).with(13)
      turtle.run(argv)
    end

    it "reads a command after blank line" do
      file=stub
      file.stub!(:readlines).and_return(['11','','FD 5'])
      File.stub!(:open).and_return(file)
      turtle.should_receive(:command).with('FD 5')
      turtle.run(argv)
    end

    it "reads a different command after blank line" do
      file=stub
      file.stub!(:readlines).and_return(['11','','RT 45'])
      File.stub!(:open).and_return(file)
      turtle.should_receive(:command).with('RT 45')
      turtle.run(argv)
    end

  end

  describe "initialization" do

    it "returns a valid set of steps" do
      turtle.steps.should == {
          0 => [  0, -1 ],
         45 => [  1, -1 ],
         90 => [  1,  0 ],
        135 => [  1,  1 ],
        180 => [  0,  1 ],
        225 => [ -1,  1 ],
        270 => [ -1,  0 ],
        315 => [ -1, -1 ]
      }
    end

    it "changes orientation to 0 when dimension is set" do
      turtle.orientation = 45
      turtle.dimension = 11
      turtle.orientation.should == 0
    end

    it "centers the turtle at [5,5] when dimension is set to 11" do
      turtle.dimension = 11
      turtle.location.should == [5,5]
      turtle.orientation.should == 0
    end

    it "centers the turtle at [6,6] when dimension is set to 13" do
      turtle.dimension = 11
      turtle.location.should == [5,5]
      turtle.orientation.should == 0
    end
  end

  describe "processes commands" do

    describe "on an 11x11 grid" do

      before(:each) do
        turtle.clear
        turtle.dimension=11
      end

      it "calls fd method for FD command" do
        turtle.should_receive(:fd).with(5,[])
        turtle.command('FD 5')
      end

      it "should have an initial location the middle" do
        turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
      end

      describe "FD x: tells the turtle to move fd by x units" do

        it "moves up 5 given centered turtle with orientation 0 and command: FD 5" do
          turtle.orientation = 0
          turtle.command('FD 5')
          turtle.output.should == <<GRID
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [5,0]
          turtle.orientation.should == 0
        end

        it "moves diagonal 5 given centered turtle with orientation 45 and command: FD 5" do
          turtle.orientation=45
          turtle.command('FD 5')
          turtle.output.should == <<GRID
. . . . . . . . . . X
. . . . . . . . . X .
. . . . . . . . X . .
. . . . . . . X . . .
. . . . . . X . . . .
. . . . . X . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [10,0]
          turtle.orientation.should == 45
        end

        it "moves horizontal 5 given centered turtle with orientation 90 and command: FD 5" do
          turtle.orientation=90
          turtle.command('FD 5')
          turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X X X X X X
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [10,5]
          turtle.orientation.should == 90
        end

        it "moves diagonal 5 given centered turtle with orientation 135 and command: FD 5" do
          turtle.orientation=135
          turtle.command('FD 5')
          turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X . . . . .
. . . . . . X . . . .
. . . . . . . X . . .
. . . . . . . . X . .
. . . . . . . . . X .
. . . . . . . . . . X
GRID
          turtle.location.should == [10,10]
          turtle.orientation.should == 135
        end

        it "moves vertically 5 given centered turtle with orientation 180 and command: FD 5" do
          turtle.orientation=180
          turtle.command('FD 5')
          turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
GRID
          turtle.location.should == [5,10]
          turtle.orientation.should == 180
        end

        it "moves diagonally 5 given centered turtle with orientation 225 and command: FD 5" do
          turtle.orientation=225
          turtle.command('FD 5')
          turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X . . . . .
. . . . X . . . . . .
. . . X . . . . . . .
. . X . . . . . . . .
. X . . . . . . . . .
X . . . . . . . . . .
GRID
          turtle.location.should == [0,10]
          turtle.orientation.should == 225
        end

        it "moves horizontally 5 given centered turtle with orientation 270 and command: FD 5" do
          turtle.orientation=270
          turtle.command('FD 5')
          turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
X X X X X X . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [0,5]
          turtle.orientation.should == 270
        end

        it "moves diagonally 5 given centered turtle with orientation 315 and command: FD 5" do
          turtle.orientation=315
          turtle.command('FD 5')
          turtle.output.should == <<GRID
X . . . . . . . . . .
. X . . . . . . . . .
. . X . . . . . . . .
. . . X . . . . . . .
. . . . X . . . . . .
. . . . . X . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [0,0]
          turtle.orientation.should == 315
        end

      end

      describe "RT x: change the turtle's current orientation by x degrees clockwise" do

        it "calls rt method for RT command" do
          turtle.should_receive(:rt).with(45,[])
          turtle.command('RT 45')
        end

        it "starting at orientation 0 turns rt by 45 degrees" do
          turtle.orientation=0
          turtle.command('RT 45')
          turtle.orientation.should == 45
        end

        it "starting at orientation 0 turns rt by 90 degrees" do
          turtle.orientation=0
          turtle.command('RT 90')
          turtle.orientation.should == 90
        end

        it "starting at orientation 45 turns rt by 90 degrees" do
          turtle.orientation=45
          turtle.command('RT 90')
          turtle.orientation.should == 135
        end

        it "starting at orientation 315 turns rt by 90 degrees" do
          turtle.orientation=315
          turtle.command('RT 90')
          turtle.orientation.should == 45
        end

      end

      describe "LT x: change the turtle's current orientation by x degrees counter-clockwise" do

        it "calls lt method for LT command" do
          turtle.should_receive(:lt).with(45,[])
          turtle.command('LT 45')
        end

        it "starting at orientation 0 turns lt by 45 degrees" do
          turtle.orientation=0
          turtle.command('LT 45')
          turtle.orientation.should == 315
        end

        it "starting at orientation 0 turns lt by 90 degrees" do
          turtle.orientation=0
          turtle.command('LT 90')
          turtle.orientation.should == 270
        end

        it "starting at orientation 315 turns lt by 90 degrees" do
          turtle.orientation=315
          turtle.command('LT 90')
          turtle.orientation.should == 225
        end

        it "starting at orientation 45 turns lt by 90 degrees" do
          turtle.orientation=45
          turtle.command('LT 90')
          turtle.orientation.should == 315
        end

      end

      describe "BK x: tells the turtle to move bks by x units, keeping its current orientation" do

        it "calls bk method for BK command" do
          turtle.should_receive(:bk).with(5,[])
          turtle.command('BK 5')
        end


        it "moves down 5 given centered turtle with orientation 0 and command: BK 5" do
	  turtle.orientation = 0
          turtle.command('BK 5')
          turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
GRID
          turtle.location.should == [5,10]
          turtle.orientation.should == 0
        end

        it "moves diagonal 5 given centered turtle with orientation 45 and command: BK 5" do
          turtle.orientation=45
          turtle.command('BK 5')
          turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X . . . . .
. . . . X . . . . . .
. . . X . . . . . . .
. . X . . . . . . . .
. X . . . . . . . . .
X . . . . . . . . . .
GRID
          turtle.location.should == [0,10]
          turtle.orientation.should == 45
        end

        it "moves horizontal 5 given centered turtle with orientation 90 and command: BK 5" do
          turtle.orientation=90
          turtle.command('BK 5')
          turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
X X X X X X . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [0,5]
          turtle.orientation.should == 90
        end

        it "moves diagonal 5 given centered turtle with orientation 135 and command: BK 5" do
          turtle.orientation=135
          turtle.command('BK 5')
          turtle.output.should == <<GRID
X . . . . . . . . . .
. X . . . . . . . . .
. . X . . . . . . . .
. . . X . . . . . . .
. . . . X . . . . . .
. . . . . X . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [0,0]
          turtle.orientation.should == 135
        end

        it "moves vertically 5 given centered turtle with orientation 180 and command: BK 5" do
          turtle.orientation=180
          turtle.command('BK 5')
          turtle.output.should == <<GRID
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . X . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [5,0]
          turtle.orientation.should == 180
        end

        it "moves diagonally 5 given centered turtle with orientation 225 and command: BK 5" do
          turtle.orientation=225
          turtle.command('BK 5')
          turtle.output.should == <<GRID
. . . . . . . . . . X
. . . . . . . . . X .
. . . . . . . . X . .
. . . . . . . X . . .
. . . . . . X . . . .
. . . . . X . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [10,0]
          turtle.orientation.should == 225
        end

        it "moves horizontally 5 given centered turtle with orientation 270 and command: BK 5" do
          turtle.orientation=270
          turtle.command('BK 5')
          turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X X X X X X
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [10,5]
          turtle.orientation.should == 270
        end

        it "moves diagonally 5 given centered turtle with orientation 315 and command: BK 5" do
          turtle.orientation=315
          turtle.command('BK 5')
          turtle.output.should == <<GRID
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X . . . . .
. . . . . . X . . . .
. . . . . . . X . . .
. . . . . . . . X . .
. . . . . . . . . X .
. . . . . . . . . . X
GRID
          turtle.location.should == [10,10]
          turtle.orientation.should == 315
        end

      end

      describe "REPEAT x [...]: tells the turtle to repeat the movements defined within the square brackets x times." do

        it "calls repeat method for REPEAT command" do
          turtle.should_receive(:repeat).with(4,[ 'FD 5', 'RT 90' ])
          turtle.command('REPEAT 4 [ FD 5 RT 90 ]')
        end
  
        it "repeats a series of commands a given number of times" do
  
          turtle.command('REPEAT 4 [ FD 5 RT 90 ]')
          turtle.output.should == <<GRID
. . . . . X X X X X X
. . . . . X . . . . X
. . . . . X . . . . X
. . . . . X . . . . X
. . . . . X . . . . X
. . . . . X X X X X X
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
GRID
          turtle.location.should == [5,5]
          turtle.orientation.should == 0
        end

      end
  
    end

  end

end
