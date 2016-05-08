

#Exercises

arr = [1,2,3,4,5,6,7,8,9,10]

#1
arr.each {|e| p e}


#2
puts ""
arr.each do |e|

  p e if e > 5

end


#3
new_arr = arr.select {|e| e.odd?}

p new_arr

#4

arr << 11

arr.unshift(0)

p arr

#5

puts ""
arr.pop
arr << 3
p arr

#6
puts ""
p arr.uniq


