# frozen_string_literal: true

require 'rspec'
require_relative '../table.rb'

describe 'Table' do
  before(:all) do
    @table = Table.new
  end
  context 'player operation' do
    it 'should create an empty table' do
      expect(@table.player).to be_nil
      expect(@table.dealer).to be_nil
    end
    it 'should add new player and dealer' do
      player = Player.new
      dealer = Dealer.new
      @table.add_to_table(player)
      expect(@table.player).not_to be_nil
      @table.add_to_table(dealer)
      expect(@table.dealer).not_to be_nil
    end
  end
  context 'bank management' do
    it 'should make bets for player and dealer' do
      expect(@table.bank).to eq(0)
      @table.make_bets
      expect(@table.bank).to eq(20)
      @table.make_bets(15)
      expect(@table.bank).to eq(30)
    end
  end
end
