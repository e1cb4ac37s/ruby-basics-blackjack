# frozen_string_literal: true

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
      if @player.balance.positive? && @dealer.balance.positive?
        print '-> Play again? (y): '
        next if gets.chomp =~ /y/i
      elsif @player.balance.zero?
        puts "You've lost all your money. Come back later, looser!"
      else
        puts 'Dealer is outta money, game is over, cowboy!'
      end
      break
    end
  end

  def round
    init_board
    round_loop
    close_board
    @dealer.show
    print_board
  end

  def round_loop
    until @round_state[:ended]
      print_board
      print '-> Your turn, your action! (1) - draw, (2) - show cards, (w/e) - skip: '
      action = gets.chomp
      case action
      when '1' then draw
      when '2' then end_round
      end
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
    end_round if @player.hand.value == 21
  end

  def draw
    @player.hand.draw(@deck.deal_card)
    end_round if @player.hand.value >= 21
  end

  def dealer_action
    value = @dealer.hand.value
    @dealer.hand.draw(@deck.deal_card) if value < 17
    end_round if @dealer.hand.value >= 21 || @player.hand.size == 3
  end

  def print_board
    puts @dealer
    puts @player
  end

  # rubocop:disable Metrics/AbcSize
  def end_round
    @round_state[:ended] = true
    return if @dealer.hand.value == @player.hand.value
    return @round_state[:looser] = @player if @player.hand.value > 21
    return @round_state[:looser] = @dealer if @dealer.hand.value > 21

    @round_state[:looser] = 21 - @player.hand.value > 21 - @dealer.hand.value ? @player : @dealer
  end
  # rubocop:enable Metrics/AbcSize

  def close_board
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
end
