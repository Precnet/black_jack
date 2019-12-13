# frozen_string_literal: true

require_relative 'blackjack_error.rb'

class Player
  attr_reader :money, :hand, :score

  def initialize(money = 100)
    @hand = []
    @score = 0
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

  private

  def validate!
    validate_positive(@money)
  end

  def validate_positive(value)
    message = 'It should be positive integer!'
    value_is_correct = value.is_a?(Integer) && value.positive?
    raise BlackjackError, message unless value_is_correct
  end
end
