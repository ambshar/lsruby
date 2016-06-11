require 'pry'
def select(array, &block)
  counter = 0
  new_array = []
  while counter < array.size

    flag = block.call(array[counter])
    new_array << array[counter] if flag
    counter += 1
  end
  new_array
end

array = [1, 2, 3, 4, 5]

a =  select(array) { |num| num.odd? }      # => [1, 3, 5]
b = select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
c =  select(array) { |num| num + 1 }   # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true

p a
p b
p c

