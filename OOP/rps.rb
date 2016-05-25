# Keeping score
class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    self.score = 0
  end
end # end Player

class Human < Player
  def set_name
    puts "Your name?"
    n = ''
    loop do
      n = gets.chomp
      break unless n == ""
      puts "please enter a name"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Choose r (rock), p (paper) or sc (scissors)"
      choice = gets.chomp

      if Move::VALID_SHORT_FORMS.key? choice
        choice = Move::VALID_SHORT_FORMS[choice]
      end
      break if Move::VALUES.include? choice
    end
    self.move = Move.new(choice)
  end
end # end Human

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Rover', 'Kit'].sample
    puts "You will be playing against #{name}"
    sleep 0.5
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors'].freeze
  VALID_SHORT_FORMS = { "r" => "rock",
                        "p" => "paper",
                        "sc" => "scissors" }.freeze

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end # end Move

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "WELCOME to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock Paper Scissors.  Good Bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def game_winner
    if human.move > computer.move
      :human
    elsif human.move < computer.move
      :computer
    end
  end

  def increment_score
    winner = game_winner
    if winner == :human
      human.score += 1
    elsif winner == :computer
      computer.score += 1
    end
  end

  def display_winner
    winner = game_winner
    if winner == :human
      puts "#{human.name} won"
    elsif winner == :computer
      puts "#{computer.name} won"
    else
      puts "It's a tie"
    end
    display_scores
  end

  def display_scores
    puts "SCORE: #{human.name} -> #{human.score} and "\
          "#{computer.name} -> #{computer.score}"
  end

  def win_condition?
    return true if human.score == 10 || computer.score == 10
    false
  end

  def play_again?
    puts "Play again? enter y or n"
    choice = nil
    loop do
      choice = gets.chomp
      break if choice.downcase.start_with?('y', 'n')
      puts "Please select from y or n"
    end
    choice == 'y' ? true : false
  end

  def play
    loop do
      human.choose
      computer.choose
      display_moves
      increment_score
      display_winner
      if win_condition? || !play_again?
        break
      end
    end
    display_goodbye_message
  end
end # end RPSGame

RPSGame.new.play
