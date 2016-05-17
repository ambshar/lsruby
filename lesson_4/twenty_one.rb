require 'pry'
SUIT = ['Diamonds', 'Clubs', 'Hearts', 'Spades'].freeze
VALUES = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10',
          'J', 'Q', 'K'].freeze
DEALER_ACE = 'soft'.freeze # ace = 11 always when soft
NUMBER_DECKS = 1
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
  hand.each do |e|
    e = e[0]
    value = case e
            when 'A'
              1
            when '1'
              1
            when '2'
              2
            when '3'
              3
            when '4'
              4
            when '5'
              5
            when '6'
              6
            when '7'
              7
            when '8'
              8
            when '9'
              9
            else
              10
            end
    sum += value
  end
  sum
end

def ace_check(hand)
  hand.each do |e|
    e = e[0]
    return true if e == 'A'
  end
  false
end

def busted?(hand)
  ace = ace_check hand
  sum = get_total hand
  if ace
    (sum > 21 && (sum + 10) > 21) ? true : false
  elsif sum > 21
    true
  else
    false
  end
end

def show_cards(hand)
  hand.map { |e| e.join('-') }.join(' ')
end

def show_dealer_initial_hand(dealer_cards)
  display_dealer = dealer_cards.sample.join('-')
  prompt "Dealer has: #{display_dealer} and unknown"
end

def show_player_message(hand)
  display_player = show_cards(hand)
  prompt "You have: #{display_player}"

  ace = ace_check(hand)
  sum = get_total(hand)

  if ace
    prompt "Worth #{sum} or #{sum + 10}"
  else
    prompt "Worth #{sum}"
  end
end

def show_dealer_message(hand)
  display_dealer = show_cards(hand)
  prompt "Dealer has: #{display_dealer}"

  ace = ace_check(hand)
  sum = get_total(hand)

  if ace
    if DEALER_ACE == 'soft'
      prompt "Worth #{sum + 10}"
    else
      prompt "Worth #{sum} or #{sum + 10}"
    end
  else
    prompt "Worth #{sum}"
  end
end

def usable_total_with_ace(sum)
  sum1 = sum
  sum2 = sum + 10
  sum2 < 22 ? sum2 : sum1
end

def dealer_total(hand)
  dealer_ace = ace_check hand
  sum_dealer = get_total hand
  if dealer_ace
    if DEALER_ACE == 'soft'
      sum_dealer + 10
    else
      usable_total_with_ace(sum_dealer)
    end
  else
    sum_dealer
  end
end

def player_total(hand)
  ace = ace_check hand
  sum = get_total hand
  if ace
    usable_total_with_ace(sum)
  else
    sum
  end
end

def get_winner(player, dealer)
  sum_player = player_total(player)
  sum_dealer = dealer_total(dealer)
  (sum_player > sum_dealer) ? 'Player' : 'Dealer'
end

def check_for_blackjack(hand)
  ace = ace_check hand
  if ace
    return (get_total(hand) + 10) == 21 ? true : false
  end
  false
end

# START
prompt "Welcome to Twenty - One.  Here are the cards"

loop do
  player_cards = []
  dealer_cards = []
  deck = []
  game_over = false

  deck = shuffle_deck
  deal_initial_hand(player_cards, dealer_cards, deck)
  show_dealer_initial_hand(dealer_cards)
  show_player_message(player_cards)
  blackjack_player = check_for_blackjack(player_cards)
  blackjack_dealer = check_for_blackjack(dealer_cards)

  if blackjack_dealer && blackjack_player
    prompt "Both have BLACKJACK.  It's a push"
    game_over = true
  elsif blackjack_player
    prompt "BLACKJACK. YOU WIN"
    game_over = true
  elsif blackjack_dealer
    prompt "BLACKJACK. DEALER WINS"
    game_over = true
  end

  loop do
    break if game_over
    choice = ''
    loop do
      prompt "Press h to Hit or s to Stay."
      choice = gets.chomp.downcase
      break if choice.downcase.start_with?('h', 's')
      prompt "Enter valid selection: h or s"
    end

    if choice == 'h'
      player_cards << deck.shift
      show_player_message(player_cards)
      if busted?(player_cards)
        prompt "BUSTED.  YOU LOSE"
        game_over = true
      end
    elsif choice == 's'
      loop do
        show_dealer_message(dealer_cards)
        if busted?(dealer_cards)
          prompt "DEALER BUSTED.  YOU WIN"
          game_over = true
          break
        end

        if dealer_total(dealer_cards) > 16
          if player_total(player_cards) == dealer_total(dealer_cards)
            prompt "It's a PUSH"
          else
            winner = get_winner(player_cards, dealer_cards)
            prompt "#{winner} wins"
          end
          game_over = true
          break
        end
        dealer_cards << deck.shift
      end
    end
  end

  prompt "play again?  press y or n"
  choice = gets.chomp.downcase
  if choice.start_with? 'n'
    break
  elsif choice.start_with? 'y'
    next
  else
    prompt "Enter valid choice"
  end
end
