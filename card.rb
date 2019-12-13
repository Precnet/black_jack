# frozen_string_literal: true

# Class for playing card representation
require_relative 'blackjack_error.rb'

class Card
  SUIT_LENGTH = 1
  VALUE_LENGTH = 2

  attr_reader :suit, :value

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
    validate_type(@suit, String)
    validate_length(@suit, SUIT_LENGTH)
  end

  def validate_value
    validate_type(@value, String)
    validate_length(@value, VALUE_LENGTH)
  end

  def validate_type(attribute, type)
    message = "'#{attribute}' should be '#{type}'! Got = '#{attribute.class}"
    raise BlackjackError, message unless attribute.is_a? type
  end

  def validate_length(attribute, length)
    message = "'#{attribute}' should have length between 0 and '#{length}'!"
    unless !attribute.empty? && attribute.length < length
      raise BlackjackError, message
    end
  end
end
