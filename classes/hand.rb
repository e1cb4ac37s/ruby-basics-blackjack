class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def draw(card)
    @cards << card
  end

  def value
    aces, value = 0, 0
    @cards.map(&:value).each { |v| v == 1 ? aces += 1 : value += v }
    aces * 11 + value <= 21 ? aces * 11 + value : aces + value
  end

  def clear
    @cards = []
  end

  def to_s
    "#{@cards.map(&:to_s).join(' ')} (#{value})"
  end
end
