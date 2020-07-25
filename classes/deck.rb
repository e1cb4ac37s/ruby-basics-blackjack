class Deck
  include Constants

  def initialize
    @cards = []
    SUITS.each do |s|
      RANKS.each { |r| @cards << Card.new(r, s) }
    end
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end
