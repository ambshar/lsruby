
h1 = {"a" => 122, "b" => 333}

h2 = {"c" => 1, "d" => 2}

a = h1.merge(h2)
puts a, h1, h2
b = h1.merge!(h2)



puts b, h1, h2