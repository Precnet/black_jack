# frozen_string_literal: true

require_relative 'player.rb'
require_relative 'dealer.rb'

class Table
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
    puts 'All bets are off!'
    @player.make_bet value
    @dealer.make_bet value
    @bank = 2 * value
  end

  def validate!
    validate_player
    validate_dealer
  end

  private

  def validate_player
    message = 'There should be a player at a table!'
    raise BlackjackError, message unless @player
  end

  def validate_dealer
    message = 'There should be a dealer at the table!'
    raise BlackjackError, message unless @dealer
  end
end
