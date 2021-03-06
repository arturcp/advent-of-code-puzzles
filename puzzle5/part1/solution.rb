require_relative '../input.rb'
require_relative '../airplane_seats.rb'
require_relative '../boarding_pass.rb'
require_relative '../instruction.rb'
require_relative '../f_instruction.rb'
require_relative '../b_instruction.rb'
require_relative '../l_instruction.rb'
require_relative '../r_instruction.rb'

max_seat_id = -1
INPUT.each do |instructions|
  seat = BoardingPass.new(instructions).seat
  # puts seat.to_s
  max_seat_id = seat.id if seat.id > max_seat_id
end

puts max_seat_id
