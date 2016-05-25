require 'pry'
def fizzbizz(num1, num2)
output = []
  (num1..num2).each do |n|
    if (n % 3 == 0) && (n % 5 == 0)
      output << "FizzBizz" 
    elsif (n % 3 == 0)
      output << "Fizz"
    elsif n % 5 == 0
      output << "Bizz"
    else
      output << n
    end
          
  end
  output.join ', '

end

p fizzbizz(1, 15)