require_relative 'player.rb'

class Dealer < Player
  def initialize(money = 100)
    super money
  end

  def take_turn
    if @score >= 17
      :pass_turn
    else
      :take_card
    end
  end
end
