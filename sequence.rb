def match_lab(word)

/lab/.match(word)

end


list = ["laboratory", "experiment", "Pan Labyrinth", "elaborate", "polar bear"]

list.each do |e|

puts e if match_lab(e)

end

