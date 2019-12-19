# frozen_string_literal: true

require_relative 'player.rb'

class Interface
  def display_statistics
    raise BlackjackError, 'Not implemented in a child class!'
  end

  def show_message
    raise BlackjackError, 'Not implemented in a child class!'
  end

  def show_menu
    raise BlackjackError, 'Not implemented in a child class!'
  end

  def user_input
    raise BlackjackError, 'Not implemented in a child class!'
  end
end
