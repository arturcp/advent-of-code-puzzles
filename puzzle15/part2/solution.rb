require_relative '../input.rb'
require_relative '../game.rb'
require_relative '../number.rb'

game = Game.new(INPUT, log_offset: 1_000)
puts game.start(30_000_000)