
require 'pry'


def gcd(num1, num2)
  result1 =[]
  result2 = []

  (1..num1).each do |n|
    result1 << n if num1 % n == 0
  end

  (1..num2).each do |n|
    result2 << n if num2 % n == 0
  end

  size = [result1.sort!.size, result2.sort!.size].min
  

  divisor = nil
 
  divisor = (result1 & result2).last

  
end

p gcd(9, 15)
p gcd(100, 11)
p gcd(14, 28)



