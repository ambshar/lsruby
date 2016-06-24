str = "hello there"

  def reverse_string(string)
    output = []
    n = -1
    string.length.times do
      output << string.slice(n)
      n -= 1
    end
    # p string
     output.join ""
  end

  
  output = reverse_string str

  p output