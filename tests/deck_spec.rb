# frozen_string_literal: true

require 'rspec'
require_relative '../deck.rb'

describe 'Deck' do
  before(:all) do
    @deck1 = Deck.new
    @deck2 = Deck.new
  end
  context 'deck creation' do
    it 'creates deck objects' do
      expect { Deck.new }.not_to raise_error
      expect(@deck1.cards.length).to eq(52)
      expect(@deck1.cards.length).to eq(@deck2.cards.length)
    end
    it 'shuffles cards in deck' do
      @deck1.shuffle!
      expect(@deck1.cards).not_to eq(@deck2.cards)
    end
    it 'takes cards for deck' do
      card = @deck1.take_card
      expect(@deck1.cards.length).to eq(51)
      expect(card.class).to be(Card)
      @deck1.take_card
      @deck1.take_card
      @deck1.take_card
      expect(@deck1.cards.length).to eq(48)
    end
  end
end
