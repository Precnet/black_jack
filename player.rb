# Class for playing card representation

class Card
  def initialize(value, suit)
    @suit = suit
    @value = value
    validate!
  end

  private

  def validate!
    validate_suit
    validate_value
  end

  def validate_suit

  end

  def validate_value

  end
end
