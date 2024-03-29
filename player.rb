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

  def score=(value)
    validate_positive(value)
    @score = value
  end

  def make_bet(value = 10)
    validate_positive(value)
    @money -= value
  end

  def clear_hand
    @hand = []
  end

  def take_bank(value)
    validate_positive(value)
    @money += value
  end

  def take_turn(input)
    begin
      choice = process_user_input(input)
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

  def prepare_to_next_round
    @score = 0
    @hand = []
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

  def process_user_input(input)
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
