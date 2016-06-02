# frozen_string_literal: true
require 'pry'

module Hand
  attr_accessor :hand_cards, :name

  def initialize
    reset
  end

  def value
    sum = 0
    hand_cards.each do |rank, _|
      value = case rank
              when 'A'
                11
              when '2'..'9'
                rank.to_i
              else
                10
              end
      sum += value
    end
    # correct for Aces
    hand_cards.select { |rank, _| rank == 'A' }.count.times do
      sum -= 10 if sum > 21
    end
    sum
  end

  def busted?
    value > 21
  end

  def reset
    @hand_cards = []
  end

  def show_cards
    hand_cards.map { |e| e.join('-') }.join(' ')
  end
end # end Hand

class Player
  include Hand
  def initialize
    set_name
    super
  end

  def set_name
    puts "Your name?"
    n = ''
    loop do
      n = gets.chomp.downcase.strip
      break unless n == ""
      puts "please enter a name"
    end
    @name = n.capitalize
  end
end # end Player

class Dealer
  include Hand

  def initialize
    set_name
    super
  end

  def set_name
    @name = ['R2D2', 'Hal', 'Rover', 'Kit'].sample
    puts "You will be playing against #{name}"
    sleep 0.5
  end
end # end Dealer

class Deck
  SUIT = ['Diamonds', 'Clubs', 'Hearts', 'Spades'].freeze
  VALUES = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10',
            'J', 'Q', 'K'].freeze
  NUMBER_DECKS = 1

  attr_reader :cards

  def initialize
    @cards = []
    NUMBER_DECKS.times do
      VALUES.product(SUIT).each do |card|
        @cards << Card.new(card)
      end
    end
    @cards.flatten! 1
    @cards.shuffle!
  end
end # end Deck

class Card
  attr_reader :type
  def initialize(type)
    @type = type
  end
end # end Card

class Game
  attr_reader :player, :dealer, :deck
  def initialize
    display_welcome_message
    @player = Player.new
    @dealer = Dealer.new
    reset
  end

  def display_welcome_message
    puts "Welcome to Twenty One"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing.  Goodbye!"
  end

  def deal_cards
    2.times do
      player.hand_cards << deck.cards.shift.type
      dealer.hand_cards << deck.cards.shift.type
    end
  end

  def show_initial_cards
    puts ""
    puts "#{dealer.name}: #{dealer.hand_cards.sample.join('-')} "\
          + " and a hidden card"
    puts "#{player.name}: #{player.show_cards}"
    puts " =>     Total:  #{player.value} "
  end

  def display_info(participant)
    puts ""
    puts "#{participant.name} hits..."
    puts "#{participant.name}: #{participant.show_cards} "
    puts " =>     Total:  #{participant.value} "
    puts ""
  end

  def player_turn
    loop do
      puts "hit (h) or stay (s)"
      choice = gets.chomp.downcase
      break if choice.start_with?('s')
      player.hand_cards << deck.cards.shift.type

      display_info(player)
      break if player.busted?
    end
  end

  def dealer_turn
    loop do
      sleep 1
      display_info(dealer)
      break if dealer.busted? || dealer.value > 16
      dealer.hand_cards << deck.cards.shift.type
    end
  end

  def show_result
    p_value = player.value
    d_value = dealer.value
    if p_value > d_value
      puts "#{player.name} won.  #{p_value} over #{d_value}"
    elsif p_value < d_value
      puts "#{dealer.name} won.  #{d_value} over #{p_value}"
    else
      puts "It's a push.  Both have #{p_value}"
    end
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
    @deck = Deck.new
    player.reset
    dealer.reset
  end

  def display_busted_message
    if player.busted?
      puts "#{player.name} Busted!!  #{dealer.name} Won."
    else
      puts "#{dealer.name} Busted!!  #{player.name} Won."
    end
  end

  def start
    loop do
      deal_cards
      show_initial_cards

      player_turn

      if player.busted?
        display_busted_message
        reset
        play_again? ? next : break
      end

      dealer_turn

      if dealer.busted?
        display_busted_message
        reset
        play_again? ? next : break
      end

      show_result

      break unless play_again?
      reset
    end
    display_goodbye_message
  end
end # end Game

Game.new.start
