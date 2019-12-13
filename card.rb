# frozen_string_literal: true

# Class for playing card representation
require_relative 'blackjack_error.rb'

class Card
  SUITS = { spades: "\u2660", hearts: "\u2665",
            diamonds: "\u2666", clubs: "\u2663" }.freeze
  VALUES = %I[a 2 3 4 5 6 7 8 9 10 j q k].freeze

  attr_reader :suit, :value

  def initialize(value, suit)
    @suit = suit
    @value = value
    validate!
  end

  def self.values
    VALUES
  end

  def self.suits
    SUITS
  end

  def to_s
    @value.to_s + SUITS[@suit]
  end

  private

  def validate!
    validate_suit
    validate_value
  end

  def validate_suit
    validate_type(@suit, Symbol)
    message = "Wrong suit for a card: '#{@suit}'!"
    raise BlackjackError, message unless SUITS.keys.include? @suit
  end

  def validate_value
    validate_type(@value, Symbol)
    message = "Wrong value for a card: '#{@value}'!"
    raise BlackjackError, message unless VALUES.include? @value
  end

  def validate_type(attribute, type)
    message = "'#{attribute}' should be '#{type}'! Got = '#{attribute.class}"
    raise BlackjackError, message unless attribute.is_a? type
  end
end
