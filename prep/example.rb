def remove_vowels(arr)
  out =[]
  arr.each do |string|
    out << string.delete('aeiou')
  end

p out
end

input = %w(green yellow black white)

remove_vowels input