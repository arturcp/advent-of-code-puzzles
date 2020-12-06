require_relative '../input.rb'
require_relative '../airplane_seats.rb'
require_relative '../boarding_pass.rb'
require_relative '../instruction.rb'
require_relative '../f_instruction.rb'
require_relative '../b_instruction.rb'
require_relative '../l_instruction.rb'
require_relative '../r_instruction.rb'

ids = []
INPUT.each do |instructions|
  seat = BoardingPass.new(instructions).seat
  ids << seat.id
end

ids = ids.sort

puts ''
ids.each_with_index do |id, index|
  puts id + 1 if ids[index + 1] && ids[index + 1] != id + 1
end
