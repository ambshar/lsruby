
def palindrome?(string)
  output = ''
  n = -1
  string.length.times do
  output << string.slice(n)

  n -= 1
  end
  output == string


end


word = "eye"

p palindrome? word