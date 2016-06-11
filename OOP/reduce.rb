def reduce(array, acc = 0)
  counter = 0

  while counter < array.size
    element = array[counter]
    acc = yield(acc, element)

    counter += 1

  end

  acc
end

array = [1, 2, 3, 4, 5]

a = reduce(array) { |acc, num| acc + num }                    # => 15
b = reduce(array, 10) { |acc, num| acc + num }                # => 25
c = reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass

p a
p b
p c