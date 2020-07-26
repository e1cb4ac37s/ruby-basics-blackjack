# frozen_string_literal: true

class Interface
  include Colorize

  def initialize(game)
    @game = game
  end

  def start
    loop do
      @game.start_round
      menu
      close_round
      if !@game.ended?
        print '-> Play again? (y): '
        next if gets.chomp =~ /y/i
      elsif @game.player_lost?
        puts "You've lost all your money. Come back later, looser!"
      else
        puts 'Dealer is outta money, game is over, cowboy!'
      end
      break
    end
  end

  private

  def menu
    until @game.round_ended?
      print_board
      print Color.brown('-> Your action => (1) - draw, (2) - show cards, (w/e) - skip: ')
      action = gets.chomp
      case action
      when '1' then draw
      when '2' then finish_round
      end
      break if @game.round_ended?

      dealer_turn
    end
  end

  def draw
    @game.draw_card
  end

  def finish_round
    @game.finish_round
  end

  def dealer_turn
    @game.dealer_turn
  end

  def print_board
    puts @game.dealer_status
    puts @game.player_status
  end

  def close_round
    print_board
    if @game.round_winner.nil?
      puts Color.brown("--- It's a draw! ---")
    elsif @game.round_winner == 'player'
      puts Color.green('--- You win! ---')
    else
      puts Color.red('--- You lose! ---')
    end
  end
end
