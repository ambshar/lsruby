puts "Hello. type something"

word = gets.chomp

loop do

  if word == "STOP"
    puts "Bye"
    break
  else
    puts "you did not type STOP.  try again"
    word = gets.chomp
  end

end

