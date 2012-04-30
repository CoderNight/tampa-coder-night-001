require File.dirname(__FILE__) + '/../lib/turtle_tracks'

describe TurtleTracks do
  let(:input) { File.dirname(__FILE__) + '/../simple.logo' }
  let(:default_output) { File.dirname(__FILE__) + '/../turtle_out.txt' }

  before(:all) do
    if File.exists?(default_output)
      renamed_file = "#{default_output}.testbak"
      File.rename(default_output, renamed_file)
    end
  end

  after(:all) do
    renamed_file = "#{default_output}.testbak"
    if File.exists?(renamed_file)
      File.rename(renamed_file, default_output)
    end
  end

  before(:each) do
    TurtleTracks.stub(:process_input)
  end

  describe '#process' do
    it 'requires at least an input path as first argument' do
      expect{ TurtleTracks.process }.to raise_error('Please supply an input file')
      expect{ TurtleTracks.process([input]) }.to_not raise_error
    end

    it 'accepts an output path as a second argument' do
      output = File.dirname(__FILE__) + '/simple_out_test.txt'
      begin; File.delete(output); rescue; end

      TurtleTracks.process([input, output])
      File.exists?(output).should be_true

      begin; File.delete(output); rescue; end
    end

    it 'defaults output path to turtle_output.txt' do
      begin; File.delete(default_output); rescue; end

      TurtleTracks.process([input])
      File.exists?(default_output).should be_true

      begin; File.delete(default_output); rescue; end
    end
  end

  describe '#read_input' do
    it 'raises an error if the input cannot be found' do
      bad_input = File.dirname(__FILE__) + '/../nothere.logo'
      expect{ TurtleTracks.process([bad_input]) }.to raise_error('Input file not found')
    end
  end

end

