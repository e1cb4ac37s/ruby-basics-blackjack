# frozen_string_literal: true

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def draw(card)
    @cards << card
  end

  def value
    aces = 0
    value = 0
    @cards.map(&:value).each { |v| v == 11 ? aces += 1 : value += v }
    aces.times { value += 11 + value > 21 ? 1 : 11 }
    value
  end

  def clear
    @cards = []
  end

  def size
    @cards.size
  end

  def to_s
    "#{@cards.map(&:to_s).join(' ')} (#{value})"
  end
end
