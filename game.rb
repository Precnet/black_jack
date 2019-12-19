# frozen_string_literal: true

require_relative 'table.rb'
require_relative 'deck.rb'
require_relative 'console_interface.rb'

class Game
  SCORES = { 'a' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
             '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'j' => 10,
             'q' => 10, 'k' => 10 }.freeze

  def initialize(interface)
    @interface = interface
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
    validate_interface
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
      @interface.display_statistics(@table.player)
      process_user_turn(@table.player)
      break if @stop_turn

      process_user_turn(@table.dealer)
      if each_player_has_three_cards?
        @interface.show_message('Both players have three cards. Open hands!')
        determine_winner
      elsif skipped_twice?
        @interface.show_message('Both players skipped turn. Open hands!')
        determine_winner
      elsif overdraw?

      end
    end
  end

  def process_user_turn(user)
    action = user.take_turn
    case action
    when :add_card
      user.add_card(@deck.take_card)
      @interface.show_message("#{user.class} takes one more card!")
    when :skip_turn
      @skipped_turns += 1
      @interface.show_message("#{user.class} skips turn!")
    when :open_hands
      @interface.show_message("#{user.class} decides to open hands!")
      determine_winner
    else
      raise BlackjackError, "Wrong input: #{action}!"
    end
  end

  def determine_winner
    calculate_scores
    @interface.show_message(get_info(@table.player))
    @interface.show_message(get_info(@table.dealer))
    user_score = get_score(@table.player)
    dealer_score = get_score(@table.dealer)
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

  def get_info(person)
    person_score = get_score(person)
    person_hand = person.hand.map(&:to_s).join(' ')
    "#{person.class}`s hand: #{person_hand}, User`s score: #{person_score}"
  end

  def get_score(person)
    person.score.to_i
  end

  def each_player_has_three_cards?
    @table.player.hand.length == 3 && @table.dealer.hand.length == 3
  end

  def skipped_twice?
    @skipped_turns > 1
  end

  def overdraw?
    calculate_scores
    @table.player.score > 21 && @stop_turn == 1
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

  def validate_interface
    @interface.is_a? Interface
  end
end

Game.new(ConsoleInterface.new).start_game if $PROGRAM_NAME == __FILE__
