# frozen_string_literal: true

require_relative 'card.rb'

class Deck
  attr_reader :cards

  def initialize
    @cards = create_deck
  end

  def shuffle!
    @cards.shuffle!
  end

  def take_card
  end

  private

  def create_deck
    deck = []
    Card.values.each do |value|
      Card.suits.each_key do |suit|
        deck.push(value.to_s + Card.suits[suit])
      end
    end
    deck
  end
end
