require 'pry'


phrase = "olly olly in come free in"

original = phrase.split

unique = original.uniq
output = {}
unique.each do |e|
  output[e] = original.count(e)
end

output.to_a.each do |e|
  p e.join(": ")
  end

