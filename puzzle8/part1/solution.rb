require_relative '../input.rb'
require_relative '../command_factory.rb'
require_relative '../controller.rb'

commands = INPUT.map { |instruction| CommandFactory.build(instruction) }
puts Controller.new(commands).execute_instructions.accumulator
