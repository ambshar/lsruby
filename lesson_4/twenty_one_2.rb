
require 'pry'
SUIT = ['Diamonds', 'Clubs', 'Hearts', 'Spades'].freeze
VALUES = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10',
          'J', 'Q', 'K'].freeze
NUMBER_DECKS = 1
WHATEVER_ONE = 21
DEALER_STAYS_AT = 17
def prompt(message)
  puts "=> #{message}"
end

def shuffle_deck
  deck = []
  NUMBER_DECKS.times do
    deck << VALUES.product(SUIT)
  end
  deck.flatten! 1
  deck.shuffle!
end

def deal_initial_hand(player, dealer, deck)
  2.times do
    player << deck.shift
    dealer << deck.shift
  end
end

def get_total(hand)
  sum = 0
  hand.each do |rank, _|
    value = if rank == 'A'
              11
            elsif rank.to_i == 0
              10
            else
              rank.to_i
            end
    sum += value
  end
  hand.select { |rank, _| rank == 'A' }.count.times do # correct for Aces
    sum -= 10 if sum > WHATEVER_ONE
  end
  sum
end

def ace_check(hand)
  hand.each do |rank, _|
    return true if rank == 'A'
  end
  false
end

def busted?(sum)
  sum > WHATEVER_ONE
end

def show_cards(hand)
  hand.map { |value_suit| value_suit.join('-') }.join(' ')
end

def show_dealer_initial_hand(dealer_cards)
  display_dealer = dealer_cards.sample.join('-')
  prompt "Dealer has: #{display_dealer} and unknown"
end

def get_winner(sum_player, sum_dealer)
  if sum_player > WHATEVER_ONE
    :player_busted
  elsif sum_dealer > WHATEVER_ONE
    :dealer_busted
  elsif sum_player > sum_dealer
    :player
  elsif sum_player < sum_dealer
    :dealer
  else
    :tie
  end
end

def show_final_hands(player_hand, dealer_hand)
  player_sum = get_total(player_hand)
  dealer_sum = get_total(dealer_hand)

  puts ""
  puts "================="
  show_message(dealer_hand, dealer_sum, 'dealer')
  show_message(player_hand, player_sum, 'player')
  puts "================="
  puts ""
end

def show_results(player_sum, dealer_sum)
  result = get_winner(player_sum, dealer_sum)
  case result
  when :player
    prompt "YOU win"
  when :dealer
    prompt "Dealer wins"
  when :player_busted
    prompt "You busted.  Dealer wins."
  when :dealer_busted
    prompt "Dealer busted.  You win."
  when :tie
    prompt "It's a push"
  end
end

def show_message(hand, sum, belongs_2)
  if belongs_2.downcase.start_with?('p')
    prompt "You have: #{show_cards(hand)} worth #{sum}"
  else
    prompt "Dealer has: #{show_cards(hand)} worth #{sum}"
  end
end

def win_tracker(player_sum, dealer_sum)
  result = get_winner(player_sum, dealer_sum)
  wins = {}
  if result == :player || result == :dealer_busted
    wins[:plyr] = 1
  elsif result == :dealer || result == :player_busted
    wins[:dlr] = 1
  end
  wins
end

def game_over?(player, dealer)
  return true if player.count == 5 || dealer.count == 5
  false
end

def play_again?
  prompt "play again?  press y or n"
  choice = ''
  loop do
    choice = gets.chomp.downcase
    break if choice.start_with?('y', 'n')
    prompt "Enter valid choice y or n"
  end
  choice.start_with?('y') ? true : false
end

def winning_message(tally)
  winner = tally.max_by {|_, score| score}[0].to_s
  if winner.start_with?('p')
    prompt "You WIN the game by #{tally[:plyr]} to #{tally[:dlr]}"
  else
    prompt "Dealer wins by #{tally[:dlr]} to #{tally[:plyr]}"
  end
end

def goodbye
  prompt "Thanks for playing.  Bye."
end

# START
prompt "Welcome to Twenty - One.  Here are the cards"
player_wins = []
dealer_wins = []
tally_wins = {plyr: 0, dlr: 0}

loop do
  player_cards = []
  dealer_cards = []
  deck = []


  deck = shuffle_deck
  deal_initial_hand(player_cards, dealer_cards, deck)
  player_sum = get_total(player_cards)

  show_dealer_initial_hand(dealer_cards)
  show_message(player_cards, player_sum, 'player')

  choice = ''
  dealer_sum = ''
  # player play
  loop do
    loop do
      prompt "Press h to Hit or s to Stay."
      choice = gets.chomp.downcase
      break if choice.downcase.start_with?('h', 's')
      prompt "Enter valid selection: Hit(h) or Stay(s)"
    end

    if choice == 'h'
      player_cards << deck.shift
      player_sum = get_total(player_cards)
      show_message(player_cards, player_sum, 'player')
    end
    break if choice == 's' || busted?(player_sum)
  end # player play

  if busted?(player_sum)
    show_final_hands(player_cards, dealer_cards)
    show_results(player_sum, dealer_sum)
    win = win_tracker(player_sum, dealer_sum)
    tally_wins.merge!(win) { |_, score1, score2| score1 + score2 }
    if tally_wins.has_value?(5)
      winning_message(tally_wins)
      break
    else
      prompt "Your wins: #{tally_wins[:plyr]} vs #{tally_wins[:dlr]} for dealer"
      play_again? ? next : break
    end
  end

  # dealer play
  loop do
    dealer_sum = get_total(dealer_cards)
    prompt "Dealer playing..."
    sleep 1
    show_message(dealer_cards, dealer_sum, 'dealer')
    break if dealer_sum >= DEALER_STAYS_AT || busted?(dealer_sum)
    dealer_cards << deck.shift
  end # dealer play

  if busted?(dealer_sum)
    show_final_hands(player_cards, dealer_cards)
    show_results(player_sum, dealer_sum)
    win = win_tracker(player_sum, dealer_sum)
    tally_wins.merge!(win) { |_, score1, score2| score1 + score2 }
    if tally_wins.has_value?(5)
      winning_message(tally_wins)
      break
    else
      prompt "Your wins: #{tally_wins[:plyr]} vs #{tally_wins[:dlr]} for dealer"
      play_again? ? next : break
    end
  end

  show_final_hands(player_cards, dealer_cards)
  show_results(player_sum, dealer_sum)
  win = win_tracker(player_sum, dealer_sum)
    tally_wins.merge!(win) { |_, score1, score2| score1 + score2 }
  if tally_wins.has_value?(5)
    winning_message(tally_wins)
    break
  else
    prompt "Your wins: #{tally_wins[:plyr]} vs #{tally_wins[:dlr]} for dealer"
    play_again? ? next : break
  end
end # main game loop
goodbye
