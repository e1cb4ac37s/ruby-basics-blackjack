class Card
  include Constants

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    return 10 if TEN_COSTS.include?(@rank)
    INDEX_COSTS.index(@rank) + 1
  end

  def to_s
    "[#{@rank}#{@suit}]"
  end
end
