# Class for playing card representation
require_relative 'blackjack_error.rb'

class Card
  def initialize(value, suit)
    @suit = suit
    @value = value
    validate!
  end

  private

  def validate!
    validate_suit
    validate_value
  end

  def validate_suit

  end

  def validate_value

  end

  def validate_type(attribute, type)
    message = "'#{attribute}' should be '#{type}'! Got = '#{attribute.class}"
    raise BlackjackError, message unless attribute.is_a? type
  end

  def validate_length(attribute, length)

  end
end
