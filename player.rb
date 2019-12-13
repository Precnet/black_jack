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
    @score += value
  end

  def make_bet(value = 10)
    message = 'Not enough money!'
    raise BlackjackError, message if (@money - value).negative?

    @money -= value
  end

  def take_bank(value)
    @money += value
  end

  private

  def validate!
    validate_money
  end

  def validate_money
    message = 'Money should be positive integer!'
    money_correct = @money.is_a?(Integer) && @money.positive?
    raise BlackjackError, message unless money_correct
  end
end
