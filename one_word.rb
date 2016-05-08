a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']


b = a.map {|e| e.to_s.split(" ")}

   
p a
p b.flatten