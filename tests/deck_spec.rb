# frozen_string_literal: true

require 'rspec'
require_relative '../deck.rb'

describe 'Deck' do
  context 'deck creation' do
    it 'creates deck objects' do
      deck = Deck.new
    end
  end
end
