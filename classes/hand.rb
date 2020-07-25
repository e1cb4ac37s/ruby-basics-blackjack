class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def draw(card)
    @cards << card
  end

  def value
    @cards.map(&:value).sum
  end

  def clear
    @cards = []
  end

  def to_s
    "#{@cards.map(&:to_s).join(' ')} (#{value})"
  end
end
