require_relative 'player.rb'

class Dealer < Player
  def initialize(table, money = 100)
    super table, money
  end

  def take_turn
    if @score >= 17
      :pass_turn
    else
      :take_card
    end
  end
end
