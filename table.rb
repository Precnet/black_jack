# frozen_string_literal: true

require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'deck.rb'

class Table
  SCORES = { 'a' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
             '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'j' => 10,
             'q' => 10, 'k' => 10 }.freeze
  attr_reader :player, :dealer, :bank

  def initialize
    @player = nil
    @dealer = nil
    @bank = 0
  end

  def add_to_table(person)
    if person.class == Player
      message = 'There is a player at the table already!'
      raise BlackjackError, message if player

      @player = person
    elsif person.is_a? Dealer
      message = 'There is a dealer at the table already!'
      raise BlackjackError, message if @dealer

      @dealer = person
    else
      message = "Should be either Player or Dealer! Got = #{person.class}"
      raise BlackjackError, message
    end
  end

  def make_bets(value = 10)
    @player.make_bet value
    @dealer.make_bet value
    @bank = 2 * value
  end
end
