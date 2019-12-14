# frozen_string_literal: true

require 'rspec'
require_relative '../player.rb'
require_relative '../table.rb'

describe 'Player' do
  before(:all) do
    @player = Player.new
  end
  context 'player operation' do
    it 'creates player objects' do
      expect { Player.new }.not_to raise_error
      expect(@player.hand).to eq([])
      expect(@player.money).to eq(100)
      expect(@player.score).to eq(0)
      expect { Player.new(0) }.to raise_error BlackjackError
      expect { Player.new(-100) }.to raise_error BlackjackError
    end
    it 'adds new cards to Player`s hand' do
      card1 = Card.new(:q, :spades)
      @player.add_card(card1)
      expect(@player.hand.length).to eq(1)
      expect(@player.hand[0]).to eq(card1)
      card2 = Card.new(:a, :diamonds)
      @player.add_card(card2)
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
      @player.make_bet
      expect(@player.money).to eq(90)
      @player.make_bet
      @player.make_bet
      expect(@player.money).to eq(70)
      @player.make_bet(20)
      expect(@player.money).to eq(50)
      expect { @player.make_bet(-10) }.to raise_error BlackjackError
      expect { @player.make_bet([10]) }.to raise_error BlackjackError
      expect { @player.make_bet('10'.to_sym) }.to raise_error BlackjackError
    end
    it 'takes bank' do
      @player.take_bank(20)
      expect(@player.money).to eq(70)
      @player.take_bank(50)
      expect(@player.money).to eq(120)
      expect { @player.take_bank(-10) }.to raise_error BlackjackError
    end
  end
  context 'taking turn' do
    it 'displays choice menu to user and process input' do
      message = "It`s your turn. Choose one of the options:\n1. Take one more card\n2. Skip turn\n3. Open hands\n"
      allow_any_instance_of(Kernel).to receive(:gets).and_return('1')
      expect { @player.take_turn }.to output(message).to_stdout
    end
    it 'should correctly prepare to next round' do
      @player.prepare_to_next_round
      expect(@player.score).to eq(0)
      expect(@player.hand).to eq([])
    end
  end
end
