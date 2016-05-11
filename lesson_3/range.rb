puts (10..100).include?(42)

# 6

famous_words = "seven years ago..."

prefix = "Four score and"

puts "#{prefix} #{famous_words}"

puts prefix + famous_words

puts famous_words.prepend prefix


# 7

def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep

p eval(how_deep)