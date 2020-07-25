# frozen_string_literal: true

class Player
  attr_accessor :balance
  attr_reader :hand

  def initialize(name)
    @name = name
    @balance = 100
    refresh
  end

  def refresh
    @hand = Hand.new
  end

  def to_s
    "#{@name} | hand: #{@hand} | balance: $#{@balance}"
  end
end
