# frozen_string_literal: true

require 'rspec'
require_relative '../card.rb'

describe 'Basic cards functionality' do
  context 'card creation' do
    it 'creates card objects' do
      expect { Card.new('2'.to_sym, :spades) }.not_to raise_error
      card1 = Card.new('2'.to_sym, :clubs)
      expect(card1.value).to eq('2'.to_sym)
      expect(card1.suit).to eq(:clubs)
      expect { Card.new(2, :diamonds) }.to raise_error BlackjackError
      expect { Card.new('22', :diamonds) }.to raise_error BlackjackError
      expect { Card.new(:some, :diamonds) }.to raise_error BlackjackError
      expect { Card.new(:q, :pearls) }.to raise_error BlackjackError
      expect { Card.new(:k, 'spades') }.to raise_error BlackjackError
    end
  end
end