# frozen_string_literal: true

require_relative 'blackjack_error.rb'

class Player
  attr_reader :money, :hand, :score

  def initialize(table, money = 100)
    @hand = []
    @score = 0
    @table = table
    table.add_to_table(self)
    @money = money
    validate!
  end

  def increase_score_by(value)
    validate_positive(value)
    @score += value
  end

  def make_bet(value = 10)
    validate_positive(value)
    @money -= value
  end

  def take_bank(value)
    validate_positive(value)
    @money += value
  end

  def take_turn
    begin
      show_choice
      choice = process_user_input
    rescue BlackjackError
      retry
    end

    case choice.to_i
    when 1
      action_add_card
    when 2
      action_skip
    when 3
      action_open_hands
    end
  end

  def add_card(card)
    @hand.push(card)
  end

  private

  def validate!
    validate_table
    validate_positive(@money)
  end

  def validate_table
    message = 'Table should be an instance of Table class!'
    raise BlackjackError, message unless @table.is_a? Table
  end

  def validate_positive(value)
    message = 'It should be positive integer!'
    value_is_correct = value.is_a?(Integer) && value.positive?
    raise BlackjackError, message unless value_is_correct
  end

  def show_choice
    puts 'It`s your turn. Choose one of the options:'
    puts '1. Take one more card'
    puts '2. Skip turn'
    puts '3. Open hands'
  end

  def process_user_input
    input = gets.chomp
    check_input(input)
    input
  end

  def check_input(input)
    message = 'Please, select either 1, 2 or 3'
    raise BlackjackError, message unless %w[1 2 3].include? input
  end

  def action_skip
    :skip_turn
  end

  def action_add_card
    :add_card
  end

  def action_open_hands
    :open_hands
  end
end
