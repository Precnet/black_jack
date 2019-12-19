# frozen_string_literal: true

require_relative 'interface.rb'

class ConsoleInterface < Interface
  def display_statistics(user)
    puts "Money: #{user.money}"
    puts "Current score: #{user.score}"
    puts "Hand: #{user.hand.map(&:to_s).join(' ')}"
    puts
  end

  def show_message(message)
    puts message
  end

  def show_menu
    puts 'It`s your turn. Choose one of the options:'
    puts '1. Take one more card'
    puts '2. Skip turn'
    puts '3. Open hands'
  end

  def user_input
    gets.chomp
  end
end
