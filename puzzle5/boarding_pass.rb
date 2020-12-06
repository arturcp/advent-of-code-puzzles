class BoardingPass
  attr_reader :instructions

  def initialize(instructions)
    @instructions = instructions
  end

  def seat
    seats = AirplaneSeats.new
    instructions.chars.each do |instruction|
      seats = Instruction.apply(instruction, seats)
    end
    seats
  end
end
