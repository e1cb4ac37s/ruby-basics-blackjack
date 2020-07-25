class App
  def start
    print '-> Enter your name: '
    name = gets.chomp

    @player = Player.new(name)
    @dealer = Dealer.new
    @round_state ||= { looser: nil, ended: false }

    game_loop
  end

  private

  def game_loop
    loop do
      round
      print '-> Play again? (y/n): '
      break if gets.chomp !~ /y/i
    end
  end

  def round
    init_board
    round_loop
    print_board
  end

  def round_loop
    while !@round_state[:ended]
      print_board
      print '-> Your turn, your action! (1) - draw, (2) - show cards, (w/e) - skip: '
      action = gets.chomp
      case action
      when '1' then draw
      when '2' then end_round
      else; end
      break if @round_state[:ended]
      dealer_action
    end
  end

  def init_board
    @round_state[:ended] = false
    @round_state[:looser] = nil
    @deck = Deck.new
    [@player, @dealer].each do |p|
      p.refresh
      p.balance -= 10
      2.times { p.hand.draw(@deck.deal_card) }
    end
  end

  def draw
    @player.hand.draw(@deck.deal_card)
    end_round if @player.hand.value >= 21
  end

  def dealer_action
    value = @dealer.hand.value
    @dealer.hand.draw(@deck.deal_card) if value < 17
    end_round if @dealer.hand.value >= 21
  end

  def print_board
    if @round_state[:ended]
      @dealer.show
      if @round_state[:looser].nil?
        puts "--- It's a draw! ---"
        [@dealer, @player].each { |p| p.balance += 10 }
      elsif @round_state[:looser] == @player
        puts '--- You lose! ---'
        @dealer.balance += 20
      else
        puts '--- You win! ---'
        @player.balance += 20
      end
    end
    puts @dealer
    puts @player
  end

  def end_round
    @round_state[:ended] = true
    return if @dealer.hand.value == @player.hand.value
    return @round_state[:looser] = @player if @player.hand.value > 21
    return @round_state[:looser] = @dealer if @dealer.hand.value > 21

    if 21 - @player.hand.value > 21 - @dealer.hand.value
      @round_state[:looser] = @player
    else
      @round_state[:looser] = @dealer
    end
  end
end