# frozen_string_literal: true

require_relative 'player.rb'

class Interface
  def display_statistics
    raise BlackjackError, 'Not implemented in a child class!'
  end
end
