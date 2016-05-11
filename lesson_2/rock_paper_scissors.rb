VALID_CHOICES = %w(rock paper scissors spock lizard)
VALID_SHORT_FORMS = %w(r p sc s l)

def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'lizard' && second == 'spock') ||
    (first == 'spock' && second == 'scissors') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'spock' && second == 'rock')
end

def expand_short_form(choice)
  case choice
  when 'r'
    'rock'
  when 'p'
    'paper'
  when 'l'
    'lizard'
  when 'sc'
    'scissors'
  when 's'
    'spock'
  end
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie")
  end
end

player_win_count = 0
computer_win_count = 0

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    prompt("You can type r for rock or p for paper and so on.  Type sc for scissors")
    choice = Kernel.gets().chomp()
    if VALID_CHOICES.include?(choice)
      break
    elsif VALID_SHORT_FORMS.include?(choice)
      choice = expand_short_form(choice)
      break
    else
      prompt("This is not a valid choice")
    end
  end # end choice input loop
  computer_choice = VALID_CHOICES.sample

  display_result(choice, computer_choice)
  prompt("You chose: #{choice} Computer chose: #{computer_choice}")
  if win?(choice, computer_choice)
    player_win_count += 1
  elsif win?(computer_choice, choice)
    computer_win_count += 1
  end
  prompt("Your score: #{player_win_count}.  Computer score: #{computer_win_count}")
  if player_win_count == 5
    prompt("You are the first to 5 wins.  You win the game")
    break
  elsif computer_win_count == 5
    prompt("Computer wins.  Bye.")
    break
  end
  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end
