class Game
  def initialize(player_name)
    @status = { playing: false, winner: nil }
    @dealer = Dealer.new
    @player = Player.new(player_name)
  end

  def start_round
    @status[:playing] = true
    @status[:winner] = nil
    @deck = Deck.new
    [@player, @dealer].each do |p|
      p.refresh_hand
      p.balance -= 10
      2.times { p.hand.draw(@deck.deal_card) }
    end
  end

  def draw_card
    @player.hand.draw(@deck.deal_card)
    compute_state
  end

  def dealer_turn
    @dealer.hand.draw(@deck.deal_card) if @dealer.hand.value < 17 && @dealer.hand.size == 2
    compute_state(true)
  end

  def finish_round(winner = nil)
    @status[:playing] = false
    @dealer.show
    if winner
      @status[:winner] = winner
      winner.balance += 20
    elsif @player.hand.value == @dealer.hand.value
      @status[:winner] = nil
      [@player, @dealer].each { |p| p.balance += 10 }
    else
      @status[:winner] = 21 - @player.hand.value > 21 - @dealer.hand.value ? @dealer : @player
      @status[:winner].balance += 20
    end
  end

  def player_status
    @player.to_s
  end

  def dealer_status
    @dealer.to_s
  end

  def player_lost?
    @player.balance.zero?
  end

  def round_ended?
    !@status[:playing]
  end

  def ended?
    @player.balance.zero? || @dealer.balance.zero?
  end

  def round_winner
    return nil if @status[:winner].nil?

    @status[:winner] == @player ? 'player' : 'dealer'
  end

  private

  def compute_state(is_dealer_turn = false)
    player_value = @player.hand.value
    dealer_value = @dealer.hand.value
    return finish_round(@dealer) if player_value > 21 || dealer_value == 21
    return finish_round(@player) if dealer_value > 21 || player_value == 21

    finish_round if @player.hand.size == 3 && is_dealer_turn
  end
end
