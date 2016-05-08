h = {:movie1 => '1975', :movie2 => '2004', :movie3 => '2013', :movie4 => '2001', :movie5 => '1981'}

h.each do |x,y|
puts "#{h[x]}"
end

a = [1975, 2004, 2013, 2001, 1981]

a.each { |x| puts "#{x}"}