# method implementation
class Multiply
  attr_reader :value
  def initialize(number)
    @value = number
  end
  def test
    yield(value, value**2)                              # passing 1 block argument at block invocation time
  end
end

a = Multiply.new(3)

# method invocation
c = 5
a.test do |num1, num2|                    # expecting 2 parameters in block implementation
  b = num1*num2 + c
  puts "#{b}"
end



def test2(&block)
  puts "What's &block? #{block}"
  puts block.class
end

test2 {2}



  def times number

    for i in 0..(number-1)
      yield(i)
    end
    number
  end




times(5) do |num|
  puts num
end