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
    loop do
      @table.player.clear_hand
      @table.dealer.clear_hand
      @table.make_bets
      distribute_initial_cards
      turn_loop
    end
  end

  def turn_loop
    @stop_turn = false
    until @stop_turn
      @skipped_turns = 0
      calculate_scores
      display_statistics(@table.player)
      process_user_turn(@table.player)
      process_user_turn(@table.dealer)
      if each_player_has_three_cards?
        puts 'Both players have three cards. Open hands!'
        determine_winner
      elsif skipped_twice?
        puts 'Both players skipped turn. Open hands!'
        determine_winner
      end
    end
  end

  def process_user_turn(user)
    action = user.take_turn
    case action
    when :add_card
      user.add_card(@deck.take_card)
      puts "#{user.class} takes one more card!"
    when :skip_turn
      @skipped_turns += 1
      puts "#{user.class} skips turn!"
    when :open_hands
      puts "#{user.class} decides to open hands!"
      determine_winner
    else
      raise BlackjackError, "Wrong input: #{action}!"
    end
  end

  def determine_winner
    calculate_scores
    user_score = @table.player.score.to_i
    dealer_score = @table.dealer.score.to_i
    puts "User`s hand: #{@table.player.hand.map(&:to_s).join(' ')}, User`s score: #{user_score}"
    puts "Dealer`s hand: #{@table.dealer.hand.map(&:to_s).join(' ')}, Dealer`s score: #{dealer_score}"
    if (user_score <= 21) && (dealer_score > 21)
      user_wins
    elsif (dealer_score <= 21) && (user_score > 21)
      dealer_wins
    elsif (user_score > 21) && (dealer_score > 21)
      draw
    elsif user_score > dealer_score
      user_wins
    elsif dealer_score > user_score
      dealer_wins
    else
      draw
    end
    @stop_turn = true
    puts
    puts
  end

  def each_player_has_three_cards?
    @table.player.hand.length == 3 && @table.dealer.hand.length == 3
  end

  def skipped_twice?
    @skipped_turns > 1
  end

  def user_wins
    @table.player.take_bank @table.bank
    puts 'User wins!'
  end

  def dealer_wins
    @table.dealer.take_bank @table.bank
    puts 'Dealer wins!'
  end

  def draw
    @table.player.take_bank @table.bank / 2
    @table.dealer.take_bank @table.bank / 2
    puts 'It`s a draw!'
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

  def display_statistics(user)
    puts "Money: #{user.money}"
    puts "Current score: #{user.score}"
    puts "Hand: #{user.hand.map(&:to_s).join(' ')}"
    puts
  end
end

Game.new.start_game if $PROGRAM_NAME == __FILE__
