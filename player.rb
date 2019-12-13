# frozen_string_literal: true

require_relative 'blackjack_error.rb'

class Player
  def initialize(money = 100)
    @hand = []
    @score = 0
    @money = money
    validate!
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
