# frozen_string_literal: true

class Dealer < Player
  def initialize
    super('Dealer')
  end

  def refresh_hand
    super
    hide
  end

  def show
    @show_cards = true
  end

  def hide
    @show_cards = false
  end

  def to_s
    return super if @show_cards

    "#{@name} | hand: #{@hand.cards.map { '[??]' }.join(' ')} | balance: $#{@balance}"
  end
end
