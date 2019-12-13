# frozen_string_literal: true

class Table
  def initialize
    @players = []
    @dealer = nil
  end

  def add_to_table(person)
    if person.class.is_a? Player
      @players.push(person)
    elsif person.class.is_a? Dealer
      message = 'There Can Be Only One... dealer!'
      raise BlackjackError, message if @dealer

      @dealer = person
    else
      message = "Should be either Player or Dealer! Got = #{person.class}"
      raise BlackjackError, message
    end
  end
end
