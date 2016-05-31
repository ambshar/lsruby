# frozen_string_literal: true
require 'pry'
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]].freeze
  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |     "
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts "     |     |     "
    puts "-----+-----+------"
    puts "     |     |     "
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts "     |     |     "
    puts "-----+-----+------"
    puts "     |     |     "
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts "     |     |     "
    puts ""
  end
  # rubocop:enable Metrics/AbcSize

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def [](key)
    @squares[key]
  end

  def unmarked_keys
    @squares.select { |_, sq| sq.unmarked? }.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def count_human_marker(squares) #  array of square objects
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  def count_markers(squares)
    squares.map(&:marker).uniq.length
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def display_unmarked_squares
    joinor(unmarked_keys)
  end

  def if_two_in_a_row(marker) # find winning lines with two human markers
    choose_squares = []
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      marked_sq = squares.select(&:marked?)
      next if marked_sq.size != 2

      choose_squares = marked_sq.select do |sq|
        sq.marker if sq.square_with(marker)
      end # get squares with human markers

      if choose_squares.size == marked_sq.size
        return line[chosen_square_index(squares)]
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def joinor(arr, delimiter = ', ', word = 'or')
    arr[-1] = "#{word} #{arr.last}" if arr.size > 1
    arr.size == 2 ? arr.join(' ') : arr.join(delimiter)
  end

  def chosen_square_index(squares)
    lines = squares.each_with_index.map { |sq, idx| idx if sq.unmarked? }
    lines.select { |e| e if !e.nil? }[0] # returns indx of empty square in line
  end
end # end Board

class Square
  INITIAL_MARKER = " "
  attr_accessor :marker
  def initialize
    @marker = INITIAL_MARKER
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def square_with(mark)
    marker == mark
  end
end # end Square

class Player
  attr_reader :marker
  attr_accessor :wins
  def initialize(marker)
    @marker = marker
    @wins = 0
  end
end # end Player

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
    @games_played = 0
  end

  def display_welcome_message
    clear_screen
    puts "Welcome to Tic Tac Toe"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing.  Goodbye!"
  end

  def clear_screen
    (system 'cls').nil? ? (system 'clear') : (system 'cls')
  end

  def display_board
    puts "You are an #{HUMAN_MARKER} and computer is an #{COMPUTER_MARKER}"
    puts ""
    puts ""
    board.draw
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def human_moves
    puts "Choose a square out of #{board.display_unmarked_squares} "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry not a valid choice"
    end
    board[square] = human.marker
  end

  def checking_markers
    return board.if_two_in_a_row(COMPUTER_MARKER) if !board.if_two_in_a_row(
      COMPUTER_MARKER).nil?
    return board.if_two_in_a_row(HUMAN_MARKER) if !board.if_two_in_a_row(
      HUMAN_MARKER).nil?
    return 5 if board[5].unmarked?
    nil
  end

  def computer_moves
    choice = checking_markers
    case choice
    when nil
      board[board.unmarked_keys.sample] = computer.marker
    else
      board[choice] = computer.marker
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker

    when HUMAN_MARKER
      human.wins += 1
      puts "YOU won."
    when COMPUTER_MARKER
      computer.wins += 1
      puts "Computer won."
    else
      puts "the board is full"
    end
    puts "SCORE: You: #{human.wins}, Computer: #{computer.wins}"
  end

  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? y/n ?"
      answer = gets.chomp.downcase.strip
      break if %w(y n).include? answer
      puts "Invalid choice. y or n?"
    end
    answer == 'y'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear_screen
  end

  def display_play_again_message
    puts "Let's play"
    puts ""
  end

  def current_marker_moves
    if @current_marker == HUMAN_MARKER
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def win_condition?
    human.wins == 5 || computer.wins == 5
  end

  def play
    display_welcome_message
    loop do
      @games_played += 1
      display_board
      loop do
        current_marker_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end
      display_result
      break if win_condition? || !play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end
end # end TTTGame

game = TTTGame.new
game.play