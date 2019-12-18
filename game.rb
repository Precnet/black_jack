class Game
  def initialize
    @table = Table.new
    @table.add_to_table(Player.new)
    @table.add_to_table(Dealer.new)
    @table.start_game
  end

  def start_game
    validate!
    construct_deck
    game_loop
  end

  private

  def validate!
    @table.validate!
  end

  def game_loop
    loop do
      @table.make_bets
      distribute_initial_cards
      calculate_scores
      display_statistics
      # @player.take_turn
    end
  end

  def construct_deck
    @deck = Deck.new
    @deck.shuffle!
  end

  def distribute_initial_cards
    2.times do
      @player.add_card(@deck.take_card)
      @dealer.add_card(@deck.take_card)
    end
  end

  def calculate_scores
    @player.increase_score_by(calculate_score(@player.hand))
    @dealer.increase_score_by(calculate_score(@dealer.hand))
  end

  def calculate_score(cards)
    has_ace = cards.any? { |card| card.value == :a }
    result = cards.map { |card| SCORES[card.value.to_s] }.sum
    result -= 10 if result > 21 && has_ace
    result
  end

  def display_statistics
    puts "Money: #{@player.money}"
    puts "Current score: #{@player.score}"
    puts "Hand: #{@player.hand.map(&:to_s).join(' ')}"
    puts
  end
end
