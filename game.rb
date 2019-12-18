# frozen_string_literal: true

require_relative 'table.rb'
require_relative 'deck.rb'

class Game
  SCORES = { 'a' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
             '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'j' => 10,
             'q' => 10, 'k' => 10 }.freeze

  def initialize
    @table = Table.new
    @table.add_to_table(Player.new)
    @table.add_to_table(Dealer.new)
  end

  def start_game
    validate!
    construct_deck
    start_new_round
  end

  private

  def validate!
    @table.validate!
  end

  def start_new_round
    @table.make_bets
    distribute_initial_cards
    turn_loop
  end

  def turn_loop
    @finish_turn = 1
    loop do
      calculate_scores
      display_statistics
      process_user_turn(@table.player.take_turn)
    end
  end

  def process_user_turn(action)
    case action
    when :add_card
      @table.player.add_card(@deck.take_card)
    when :skip_turn
      @table.dealer.take_turn
      each_player_has_three_cards?
    when :open_hands
      check_scores
    else
      raise BlackjackError, "Wrong input: #{action}!"
    end
  end

  def check_scores
    user_score = @table.player.score
    dealer_score = @table.dealer.score

  end

  def each_player_has_three_cards?
    # TODO
  end

  def skipped_twice?
    # TODO
  end

  def construct_deck
    @deck = Deck.new
    @deck.shuffle!
  end

  def distribute_initial_cards
    2.times do
      @table.player.add_card(@deck.take_card)
      @table.dealer.add_card(@deck.take_card)
    end
  end

  def calculate_scores
    @table.player.score = calculate_score(@table.player.hand)
    @table.dealer.score = calculate_score(@table.dealer.hand)
  end

  def calculate_score(cards)
    has_ace = cards.any? { |card| card.value == :a }
    result = cards.map { |card| SCORES[card.value.to_s] }.sum
    result -= 10 if result > 21 && has_ace
    result
  end

  def display_statistics
    puts "Money: #{@table.player.money}"
    puts "Current score: #{@table.player.score}"
    puts "Hand: #{@table.player.hand.map(&:to_s).join(' ')}"
    puts
  end
end

Game.new.start_game
