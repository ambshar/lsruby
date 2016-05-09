

def count_down(num)

   if num <= 0 
    puts num
  else
    puts num
    num -= 1
    count_down(num)
  end

end


count_down(15)
