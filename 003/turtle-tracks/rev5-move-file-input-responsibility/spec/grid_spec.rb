require File.dirname(__FILE__) + '/../lib/grid'

describe Grid do
  let(:size) { 10 }
  let(:grid) { Grid.new(size) }

  it 'requires a size parameter' do
    expect{ Grid.new }.to raise_error('Missing size parameter')
  end

  it 'accepts an int passed as a string for size' do
    grid = Grid.new('10')
    grid.size.should == 10
  end

  describe '#rows' do
    it 'is a 2 dimensional array' do
      grid.rows.should be_a_kind_of(Array)
      grid.rows[0].should be_a_kind_of(Array)
    end

    it 'is the same length as the grid size' do
      grid.rows.length.should == size
    end

    it 'has columns with the same length as the grid size' do
      grid.rows[0].length.should == size
    end

    it 'defaults spaces to ". "' do
      grid.rows[0][0].should == '. '
    end

    it 'defaults the last horizontal space to "."' do
      grid.rows[0][9].should == '.'
    end
  end

  describe '#mark_position' do
    it 'marks the given position on the grid with an "X "' do
      position = { :x => 3, :y => 3 }
      grid.mark_position(position)
      grid.rows[2][2].should == '. '
      grid.rows[3][3].should == 'X '
      grid.rows[4][3].should == '. '
    end

    it 'marks the last horizontal position on the grid with an "X"' do
      position = { :x => 9, :y => 3 }
      grid.mark_position(position)
      grid.rows[3][9].should == 'X'
    end
  end

  describe '#to_s' do
    it 'outputs a string with rows separated by newlines' do
      grid = Grid.new(3)
      grid.mark_position({:x => 0, :y => 1})
      grid.mark_position({:x => 1, :y => 1})
      grid.to_s.should == ". . .\nX X .\n. . .\n"
    end
  end

end

