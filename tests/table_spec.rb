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
      # expect(@table.players.length).to eq(1)
      # expect(@table.dealer).not_to be_nil
    end
  end
end
