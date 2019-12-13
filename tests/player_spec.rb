# frozen_string_literal: true

require 'rspec'
require_relative '../player.rb'
require_relative '../table.rb'

describe 'Player' do
  before(:all) do
    @player = Player.new(Table.new)
  end
  context 'player operation' do
    it 'creates player objects' do
      expect { Player.new(Table.new) }.not_to raise_error
      expect(@player.hand).to eq([])
      expect(@player.money).to eq(100)
      expect(@player.score).to eq(0)
      expect { Player.new(0) }.to raise_error BlackjackError
      expect { Player.new(-100) }.to raise_error BlackjackError
    end
    it 'adds new cards to Player`s hand' do
      card1 = Card.new(:q, :spades)
      @player.action_add_card(card1)
      expect(@player.hand.length).to eq(1)
      expect(@player.hand[0]).to eq(card1)
      card2 = Card.new(:a, :diamonds)
      @player.action_add_card(card2)
      expect(@player.hand.length).to eq(2)
    end
    it 'increases player`s score' do
      @player.increase_score_by(10)
      expect(@player.score).to eq(10)
      @player.increase_score_by(100)
      expect(@player.score).to eq(110)
      expect { @player.increase_score_by('100') }.to raise_error BlackjackError
      expect { @player.increase_score_by(-20) }.to raise_error BlackjackError
    end
    it 'makes bets by reducing amount of money by 10' do
      @player.action_make_bet
      expect(@player.money).to eq(90)
      @player.action_make_bet
      @player.action_make_bet
      expect(@player.money).to eq(70)
      @player.action_make_bet(20)
      expect(@player.money).to eq(50)
      expect { @player.action_make_bet(-10) }.to raise_error BlackjackError
      expect { @player.action_make_bet([10]) }.to raise_error BlackjackError
      expect { @player.action_make_bet('10'.to_sym) }.to raise_error BlackjackError
    end
    it 'takes bank' do
      @player.take_bank(20)
      expect(@player.money).to eq(70)
      @player.take_bank(50)
      expect(@player.money).to eq(120)
      expect { @player.take_bank(-10) }.to raise_error BlackjackError
    end
    it 'ski'
  end
end
