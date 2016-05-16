PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]].freeze
STARTS_FIRST = 'choose'.freeze

def prompt(message)
  puts "=> #{message}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear' || 'cls'
  prompt "You are an #{PLAYER_MARKER} and computer is an #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |     "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |     "
  puts "-----+-----+------"
  puts "     |     |     "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+------"
  puts "     |     |     "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
end
# rubocop:enable Metrics/AbcSize

def test_values
  # used to pre populate board for testing
  brd = {}
  brd[1] = 'O'
  brd[2] = 2
  brd[3] = 3
  brd[4] = 'X'
  brd[5] = 5
  brd[6] = 6
  brd[7] = 7
  brd[8] = 8
  brd[9] = 9
  brd
end

def sq_test_values
  # used to pre populate board for testing
  sq = [2, 3, 5, 6, 7, 8, 9]
  sq
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = num }
  new_board
end

def joinor(ary, separator = ', ', last = 'or')
  inside_array = ary.clone
  inside_array[-1] = last + ' ' + ary.last.to_s if ary.size > 1
  inside_array.join(separator)
end

def player_chooses!(brd, squares_available)
  sq_available = squares_available.clone
  brd_minimax = brd.clone
  move = minimax('player', brd_minimax, sq_available)
  puts "Suggested move: #{move}"
  prompt "Choose a position out of #{joinor(squares_available)}"
  choice = ''
  loop do
    choice = gets.chomp
    break if squares_available.include? choice.to_i
    puts "Enter available square numbers only"
  end
  # this is a call which mutates the squares_available array
  squares_available.delete(choice.to_i)
  # this is a call which mutates the initialized board hash inside the method
  brd[choice.to_i] = PLAYER_MARKER
end

def find_square_for_next_move(brd, choices, marker)
  WINNING_LINES.each do |line|
    next if (line & choices).size != 2
    likely_spot = (line - choices).first
    # ensure 3rd spot not occupied by a choice made by computer earlier
    return likely_spot if brd[likely_spot] != marker
  end
  nil
end

def get_computer_choice(brd, squares_available)
  player_choices = brd.select { |_, v| v == PLAYER_MARKER }.keys
  computer_choices = brd.select { |_, v| v == COMPUTER_MARKER }.keys

  likely_spot = find_square_for_next_move(brd, computer_choices,
                                          PLAYER_MARKER) # offense
  return likely_spot if likely_spot

  likely_spot = find_square_for_next_move(brd, player_choices,
                                          COMPUTER_MARKER) # defense
  return likely_spot if likely_spot

  return 5 if (brd[5] != PLAYER_MARKER) && (brd[5] != COMPUTER_MARKER)

  squares_available.sample
end

def computer_chooses!(brd, squares_available)
  sq_available = squares_available.clone
  brd_minimax = brd.clone
  computer_choice = minimax('computer', brd_minimax, sq_available)

  # computer_choice = get_computer_choice(brd, squares_available)

  brd[computer_choice] = COMPUTER_MARKER
  squares_available.delete computer_choice
  sleep 0.5
  puts "Computer chose the square #{computer_choice}"
end

def board_full(squares_available)
  squares_available.empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def score(brd)
  # method to calc score for minimax algorithm
  if someone_won?(brd)
    detect_winner(brd) == 'Player' ? 10 : -10
  else
    0
  end
end

def get_new_state(turn, brd, move)
  new_board = brd.clone
  (turn == 'player') ? new_board[move] = PLAYER_MARKER : +
                       new_board[move] = COMPUTER_MARKER
  new_board
end

def toggle(turn)
  (turn == 'player') ? 'computer' : 'player'
end

def minimax(turn, brd, sq_available)
  return score(brd) if game_over?(brd, sq_available)

  scores = []
  moves = []

  sq_available.each do |move|
    possible_board = get_new_state(turn, brd, move)
    possible_sq_available = sq_available.clone.delete_if { |e| e == move }
    scores.push minimax(toggle(turn), possible_board, possible_sq_available)
    moves.push move
  end

  if turn == 'player'
    max_score_index = scores.each_with_index.max[1]
    return moves[max_score_index]
  else
    min_score_index = scores.each_with_index.min[1]
    return moves[min_score_index]
  end
end

def play_the_game(current_player, brd, squares_available)
  if current_player == 'player'
    player_chooses!(brd, squares_available)
  else
    computer_chooses!(brd, squares_available)
  end
end

def game_over?(brd, squares_available)
  board_full(squares_available) || someone_won?(brd)
end

def alternate_player(current_player)
  (current_player == 'player') ? 'computer' : 'player'
end

# START
prompt "Welcome to Tic Tac Toe.  You can choose any available square from 1 - 9"
prompt "Your choice will be marked as X.  Computers choice will be O"
if STARTS_FIRST == 'choose'
  prompt "Enter starting player. c for computer. m for yourself"
  starter = gets.chomp
  loop do
    if starter.downcase.start_with?('c')
      starter = 'computer'
      break
    elsif starter.downcase.start_with?('m')
      starter = 'player'
      break
    else
      prompt "invalid choice.  choose again."
    end
  end
else
  starter = STARTS_FIRST
end

player_win_count = 0
computer_win_count = 0

loop do # main loop asking you want to play again?
  current_player = starter
  board = initialize_board
  display_board(board)
  squares_available = [] # tracking squares available as game proceeds
  (1..9).each { |num| squares_available << num } # init squares availble

  loop do # game loop.  ends on a result win lose or tie
    display_board(board)
    play_the_game(current_player, board, squares_available)
    break if game_over?(board, squares_available)
    current_player = alternate_player(current_player)
  end

  display_board(board)
  if someone_won?(board)
    prompt "#{detect_winner(board)} won"
    detect_winner(board) == 'Player' ? player_win_count += 1 : +
                                       computer_win_count += 1
  else
    prompt "It's a tie"
  end

  prompt "Player wins: #{player_win_count}  Computer wins #{computer_win_count}"

  if player_win_count == 5 || computer_win_count == 5
    prompt "Game Over"
    break
  else
    prompt "You want to play again? y or n"
    response = gets.chomp
    break unless response.downcase.start_with? "y"
  end
end

prompt "Thanks for playing.  Bye."
