
def generate_fibonacci_series(num)
  output = []

  num.times do |n|
    output << fibonacci(n) 
    p n
  end
output
end

def fibonacci(num)
  # generating fibonacci number at a particular index
  num > 1 ? fibonacci(num - 1) + fibonacci(num - 2)  : num

end

def select_array(arr)
  output = []
  arr.each_with_index do |e, idx|
    if generate_fibonacci_series(10).include?(idx)
      output << e
    end

  end
  output
end

p generate_fibonacci_series 3  # argument is the length of series


array = [3, 5, 77, 2, 1, 0, 33, 6, 10, 23, 101]

p array


#p select_array(array)
