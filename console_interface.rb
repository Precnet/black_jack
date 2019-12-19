# frozen_string_literal: true

require_relative 'interface.rb'

class ConsoleInterface < Interface
  def display_statistics(user)
    puts "Money: #{user.money}"
    puts "Current score: #{user.score}"
    puts "Hand: #{user.hand.map(&:to_s).join(' ')}"
    puts
  end
end
