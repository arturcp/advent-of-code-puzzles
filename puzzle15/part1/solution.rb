require_relative '../input.rb'
require_relative '../game.rb'
require_relative '../number.rb'

game = Game.new(INPUT)
puts game.start(2020)