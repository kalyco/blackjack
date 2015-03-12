# !/usr/bin/env ruby
require 'pry'

SUIT = %w(♠️, ♥️, ♣️, ♦️)
RANK = %w(A 2 3 4 5 6 7 8 9 10 J Q K)

######CARD CLASS######

class Card
attr_accessor :rank, :suit
  def initialize(rank, suit)
  @rank = rank
  @suit = suit
  end
  def face_card?
    ["J", "Q", "K"].include?(rank)
  end
  def ace?
    ["A"].include?(rank)
  end
end
######DECK CLASS#####

class Deck
  def initialize
    @cards = deck_build
    @discard = []
  end
  def deck_build
    deck = []
    SUIT.each do |suit|
      RANK.each do |rank|
        deck << Card.new(rank, suit)
      end
    end
    deck.shuffle
  end
  def deal
    dealt_card = @cards.pop
    @discard.push(dealt_card)
    return dealt_card
  end
end

#####HAND CLASS#####

class Hand
  attr_accessor :deck, :random, :hand, :total, :user, :win
  def initialize(deck, user)
  @deck = deck
  @random = random
  @hand = []
  @total = total
  @user = user
  @win = win
  end
  def card_deal(user)
    puts "#{@user} was dealt #{@hand.last.rank}#{hand.last.suit}"
  end
  def random_card
    @deck.deal
  end
  def new_hand
    @hand = []
    @hand << random_card
    if @user == "Player"
    puts "#{@user} was dealt #{@hand.last.rank}#{hand.last.suit}"
    else puts "Dealer was dealt card"
    end
    @hand << random_card
    puts "#{@user} was dealt #{@hand.last.rank}#{hand.last.suit}"
  end
  def hit
    @hand << random_card
  end
  def card_check
    total = 0
    ace_check = nil
    @hand.each do |check|
      if check.face_card?
        value = 10
      elsif check.ace?
        value = 11
        ace_check = true
      else
        value = check.rank.to_i
      end
      total += value
    end
    if ace_check == true && total > 21
      total -= 9
    end
    total
  end
  def bust
    puts "#{card_check}! Player bust! Dealer wins!"
    @win == false
  end
  def player_game
    input = ""
    until input == "stay" || card_check >= 21
      puts "Player has #{card_check}. hit or stay?"
      input = gets.chomp
      if input == "hit"
      hit
      card_deal("Player")
      card_check
      elsif input != "stay"
      puts "please type 'hit' or 'stay'"
      end
    end
    if input == "stay"
      puts "Player stays"
    end
  if card_check >= 21
    if card_check == 21
      puts "Player has 21!"
      @win = true
    else bust
    end
  end
    def dealer_game
      unless @win == true || @win == false
        while card_check < 17
          hit
          puts "Dealer hits."
          card_deal("Dealer")
        end
      end
        if card_check > 17 && card_check <= 21 && (@win != true || @win != false)
          puts "Dealer stays"
          puts "Dealer has #{card_check}."
        elsif card_check > 21
          puts "Dealer has #{card_check}. Dealer busts. Player wins!"
        else
          puts "Dealer has #{card_check}"
        end
    end
  end
end


def blackjack
  player = Hand.new(Deck.new, "Player")
  dealer = Hand.new(Deck.new, "Dealer")
  player.new_hand
  dealer.new_hand
  player.card_check
  player.player_game
  if player.card_check <= 21
  dealer.card_check
  dealer.dealer_game
  end
  unless dealer.card_check > 21 || player.card_check > 21
    if dealer.card_check >= player.card_check
      puts "Dealer wins!"
    else puts "Player Wins!"
    end
  end
end

blackjack
