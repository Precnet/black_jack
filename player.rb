# frozen_string_literal: true

require_relative 'blackjack_error.rb'

class Player
  ROLES = %I[player dealer].freeze

  def initialize(money = 100, role = :player)
    @hand = []
    @score = 0
    @money = money
    validate!
  end

  private

  def validate!
    validate_money
    validate_role
  end

  def validate_money
    message = 'Money should be positive integer!'
    money_correct = @money.is_a?(Integer) && @money.positive?
    raise BlackjackError, message unless money_correct
  end

  def validate_role
    message_type = 'Role should be a symbol!'
    raise BlackjackError, message_type unless @role.is_a? Symbol

    message_value = "Role should be either ':player' or ':dealer'!"
    raise BlackjackError, message_value unless ROLES.include? @role
  end
end
