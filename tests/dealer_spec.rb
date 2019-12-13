# frozen_string_literal: true

require 'rspec'
require_relative '../dealer.rb'
require_relative '../table.rb'

describe 'Dealer' do
  before(:all) do
    @dealer = Dealer.new(Table.new)
  end
  context 'dealer operation' do
    it 'should create dealer objects' do

    end
  end
end
