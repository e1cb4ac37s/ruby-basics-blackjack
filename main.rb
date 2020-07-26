# frozen_string_literal: true

require_relative 'requires'

print '-> Enter your name: '
name = gets.chomp

game = Game.new(name)
app = Interface.new(game)
app.start
