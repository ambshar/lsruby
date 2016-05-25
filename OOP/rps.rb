require 'pry'

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end

  def expand(c)
    case c
    when 'r'
      'rock'
    when 'p'
      'paper'
    when 's'
      'scissors'
    else
      false
    end
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
      puts "Please Choose rock, paper or scissors using r, p or s keys"
      choice = gets.chomp[0]
      choice = expand(choice)

      break if Move::VALUES.include? choice

      puts "Please select from r p or s"
    end
    self.move = Move.new(choice)
  end
end # end Human

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Rover', 'Kit'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors'].freeze

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
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock Paper Scissors.  Good Bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won"
    elsif human.move < computer.move
      puts "#{computer.name} won"
    else
      puts "It's a tie"
    end

    # case human.move
    # when 'rock'
    #   puts "It's a tie" if computer.move == human.move
    #   puts "#{human.name} won" if computer.move == 'scissors'
    #   puts "#{computer.name} won" if computer.move == 'paper'
    # when 'paper'
    #   puts "It's a tie" if computer.move == human.move
    #   puts "#{human.name} won" if computer.move == 'rock'
    #   puts "#{computer.name} won" if computer.move == 'scissors'

    # when 'scissors'
    #   puts "It's a tie" if computer.move == human.move
    #   puts "#{human.name} won" if computer.move == 'paper'
    #   puts "#{computer.name} won" if computer.move == 'rock'
    # end
  end

  def play_again?
    choice = nil
    loop do
      choice = gets.chomp
      break if choice.downcase.start_with?('y', 'n')
      puts "Please select from y or n"
    end
    choice == 'y' ? true : false
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      puts "Play again? enter y or n"
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
