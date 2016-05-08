arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']



puts arr.delete_if {|e| e.start_with?("s")}

arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

puts arr.delete_if {|e| e.start_with?("s") || e.start_with?("w")}
