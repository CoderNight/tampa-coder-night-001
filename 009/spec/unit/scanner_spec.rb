require 'spec_helper'

describe Scanner do

  before do
    text = <<-EOF.gsub(/^\s*/, '')
      FD 10 REPEAT 2 [ RT 90 ]
      LT 20 LT 30
    EOF

    @expected_tokens = %w( FD 10 REPEAT 2 [ RT 90 ] LT 20 LT 30 )

    @scanner = Scanner.new(text)
  end

  describe "#next" do
   
    it "returns and removes a token from itself" do
      @expected_tokens.each do |token|
        @scanner.next.should eql token
      end
    end 

    it "returns nil when empty" do
      scanner = Scanner.new('')
      scanner.next.should eql nil
    end 

  end

  describe "#clone" do
    it "deep clones the scanner" do
      cloned_scanner = @scanner.clone

      @scanner.next
      @scanner.next
      @scanner.next

      @expected_tokens.each do |token|
        cloned_scanner.next.should eql token
      end
    end
  end

end
