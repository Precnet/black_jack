# frozen_string_literal: true

require 'rspec'
require_relative '../dealer.rb'

describe 'Dealer' do
  before(:all) do
    @dealer = Dealer.new
  end
  context 'dealer operation' do
    it 'should create dealer objects' do
      expect { Dealer.new }.not_to raise_error
    end
  end
  context 'taking turn' do
    it 'should correctly process their turn' do
      expect(@dealer.score).to eq(0)
      @dealer.score = 10
      expect(@dealer.take_turn).to eq(:add_card)
      @dealer.score = 15
      expect(@dealer.score).to eq(15)
      expect(@dealer.take_turn).to eq(:add_card)
      @dealer.score = 20
      expect(@dealer.score).to eq(20)
      expect(@dealer.take_turn).to eq(:skip_turn)
    end
  end
end
