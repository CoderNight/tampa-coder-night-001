class Interpreter

  def initialize(turtle)
    @turtle = turtle
  end

  def parse(scanner)
    while token = scanner.next
      case token
        when 'FD'
          @turtle.forward(scanner.next.to_i)
        when 'BK' 
          @turtle.reverse(scanner.next.to_i)
        when 'RT'
          @turtle.right(scanner.next.to_i)
        when 'LT'
          @turtle.left(scanner.next.to_i)
        when 'REPEAT'
          parse_repeat(scanner)
        when ']'
          return
      end
    end
  end

  private

  def parse_repeat(scanner)
    times = scanner.next
    scanner.next

    1.upto(times.to_i - 1) do
      parse(scanner.clone)
    end

    parse(scanner)
  end

end
