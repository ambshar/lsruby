# The program will first randomly pick a number between 1 and 100. The program
# will then ask the user to guess the number. If the user guesses correctly,
# the program will end. If the user guessed too high or low, the program will
# respond with "Your number is too high" or "Your number is too low"
# respectively, and allow the user to guess again. After finally guessing the
# number, the program will display how many guesses the user took to guess
# the number.

number = (1..100).to_a.sample
number_guesses = 0

loop do
  puts "Input your guess"
  number_guesses += 1

  guess = gets.chomp.to_i

  if number == guess
    puts "You got it.  It took you #{number_guesses} guesses"
    break
  elsif guess < number
    puts "Your guess is lower"
  else
    puts "Your guess is higher"
  end
end
