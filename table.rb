# frozen_string_literal: true

require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'deck.rb'

class Table
  SCORES = { 'a' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
             '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'j' => 10,
             'q' => 10, 'k' => 10 }.freeze
  attr_reader :player, :dealer, :deck

  def initialize
    @player = nil
    @dealer = nil
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

  def start_game
    validate!
    construct_deck
    # ToDo
    # make_bets
    distribute_initial_cards
    calculate_scores
    display_statistics
    @player.take_turn
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
    has_ace = cards.any? { |card| card.value == :a }
    result = cards.map { |card| SCORES[card.value.to_s] }.sum
    result -= 10 if result > 21 && has_ace
    result
  end

  def display_statistics
    puts "Money: #{@player.money}"
    puts "Current score: #{@player.score}"
    puts "Hand: #{@player.hand.map(&:to_s).join(' ')}"
    puts
  end
end

table = Table.new
table.add_to_table(Player.new)
table.add_to_table(Dealer.new)
table.start_game
