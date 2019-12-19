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
    @cards.delete_at(0)
  end

  private

  def create_deck
    deck = []
    Card::VALUES.each do |value|
      Card::SUITS.each_key do |suit|
        deck.push(Card.new(value, suit))
      end
    end
    deck
  end
end
