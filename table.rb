# frozen_string_literal: true

require_relative 'player.rb'
require_relative 'dealer.rb'

class Table
  SCORES = {}
  attr_reader :player, :dealer

  def initialize
    @player = nil
    @dealer = nil
  end

  def add_to_table(person)
    if person.is_a? Player
      message = 'There is a player at the table already!'
      raise BlackjackError, message if player

      @player = person
    elsif person.is_a? Dealer
      message = 'There Can Be Only One... dealer!'
      raise BlackjackError, message if @dealer

      @dealer = person
    else
      message = "Should be either Player or Dealer! Got = #{person.class}"
      raise BlackjackError, message
    end
  end

  def start_game
    validate!
    construct_deck
    distribute_initial_cards
    calculate_scores
  end

  private

  def validate!
    validate_player
    validate_dealer
  end

  def validate_player
    message = 'There should be a player at a table!'
    raise BlackjackError, message unless @player
  end

  def validate_dealer
    message = 'There should be a dealer at the table!'
    raise BlackjackError, message unless @dealer
  end

  def construct_deck
    @deck = Deck.new
    @deck.shuffle!
  end

  def distribute_initial_cards
    @player.add_card(@deck.take_card)
    @player.add_card(@deck.take_card)
    @dealer.add_card(@deck.take_card)
    @dealer.add_card(@deck.take_card)
  end

  def calculate_scores
    @player.increase_score_by(calculate_score(@player.hand))
    @dealer.increase_score_by(calculate_score(@dealer.hand))
  end

  def calculate_score(cards)
  end
end
