class Scanner

  def initialize(text)
    @text = text.split(/\s+/)
  end

  def next
    @text.shift
  end

  def clone
    Scanner.new(@text.join(' '))
  end

end
