# frozen_string_literal: true

class Card
  include Constants

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    return 11 if ace?
    return 10 if JQK.include?(@rank)

    @rank.to_i
  end

  def to_s
    "[#{@rank}#{@suit}]"
  end

  def ace?
    @rank == ACE
  end
end
