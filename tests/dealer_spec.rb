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
      @dealer.increase_score_by(10)
      expect(@dealer.take_turn).to eq(:take_card)
      @dealer.increase_score_by(5)
      expect(@dealer.score).to eq(15)
      expect(@dealer.take_turn).to eq(:take_card)
      @dealer.increase_score_by(5)
      expect(@dealer.score).to eq(20)
      expect(@dealer.take_turn).to eq(:pass_turn)
    end
  end
end
