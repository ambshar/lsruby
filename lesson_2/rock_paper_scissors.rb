VALID_CHOICES = %w(rock paper scissors spock lizard)
VALID_SHORT_FORMS = {
  "r" => "rock",
  "p" => "paper",
  "sc" => "scissors",
  "s" => "spock",
  "l" => "lizard"
}

ENCOUNTER_RULES = {
  rock: [:scissors, :lizard],
  paper: [:rock, :spock],
  scissors: [:paper, :lizard],
  lizard: [:spock, :paper],
  spock: [:scissors, :rock]
}

def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  ENCOUNTER_RULES[first.to_sym].include? second.to_sym
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("YOU WON!")
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
    choice = VALID_SHORT_FORMS[choice] if VALID_SHORT_FORMS.key? choice

    if VALID_CHOICES.include?(choice)
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
    prompt("You are the first to 5 wins.  YOU WIN THE GAME")
    break
  elsif computer_win_count == 5
    prompt("Computer wins.  Bye.")
    break
  end
end
