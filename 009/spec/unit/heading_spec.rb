require 'spec_helper'

describe Heading do
  before do
    @heading = Heading.new()
  end

  describe '#initialize' do
    it '#forward returns North' do
      @heading.forward().should eql 'North'
    end

    it '#reverse returns South' do
      @heading.reverse().should eql 'South'
    end
  end

  describe '#rotate_right' do
    it 'with degrees not divisible by 45 raises ArgumentError' do
      lambda { @heading.rotate_right(130) }.should raise_error(ArgumentError)
    end

    list = [
      { :degree => 90, :forward => 'East', :reverse => 'West' },
      { :degree => 45, :forward => 'NorthEast', :reverse => 'SouthWest' },
      { :degree => -45, :forward => 'NorthWest', :reverse => 'SouthEast'},
      { :degree => 360, :forward => 'North', :reverse => 'South' },
      { :degree => 0,   :forward => 'North', :reverse => 'South' },
      { :degree => 405, :forward => 'NorthEast', :reverse => 'SouthWest' },
    ]

    list.each do |data|

      it "with #{data[:degree]} forward=>#{data[:forward]} reverse=>#{data[:reverse]}" do
        @heading.rotate_right(data[:degree])
        @heading.forward().should eql data[:forward]
        @heading.reverse().should eql data[:reverse]
      end
    end
  end

  describe '#rotate_left' do
    it 'with degrees not divisible by 45 raises ArgumentError' do
      lambda { @heading.rotate_left(47) }.should raise_error(ArgumentError)
    end

    list = [
      { :degree => 90, :forward => 'West', :reverse => 'East' },
      { :degree => 45, :forward => 'NorthWest', :reverse => 'SouthEast' },
      { :degree => -45, :forward => 'NorthEast', :reverse => 'SouthWest' },
      { :degree => 360, :forward => 'North', :reverse => 'South' },
      { :degree => 0,   :forward => 'North', :reverse => 'South' },
    ]

    list.each do |data|

      it "with #{data[:degree]} forward=>#{data[:forward]} reverse=>#{data[:reverse]}" do
        @heading.rotate_left(data[:degree])
        @heading.forward().should eql data[:forward]
        @heading.reverse().should eql data[:reverse]
      end
    end
  end

end
