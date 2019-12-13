# frozen_string_literal: true

require_relative 'blackjack_error.rb'

class Player
  attr_reader :money, :hand, :score

  def initialize(table, money = 100)
    @hand = []
    @score = 0
    @table = table
    @money = money
    validate!
  end

  def add_card(card)
    @hand.push(card)
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

  def skip
    :skip_turn
  end

  def open_hands
    :open_hands
  end

  private

  def validate!
    validate_table
    validate_positive(@money)
  end

  def validate_table
    message = 'Table should be an instance of Talbe class!'
    raise BlackjackError, message unless @table.is_a? Table
  end

  def validate_positive(value)
    message = 'It should be positive integer!'
    value_is_correct = value.is_a?(Integer) && value.positive?
    raise BlackjackError, message unless value_is_correct
  end
end
