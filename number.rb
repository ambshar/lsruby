def compare(n)

  case
    when n <= 50
      "between 0 and 50"

    when n <= 100
      "between 51 and 100"

    else
      "above 100"

    end

end

puts "number please"

number = gets.chomp.to_i

puts "Number is #{compare(number)}"