require_relative '../input.rb'

class AirplaneSeats
  attr_accessor :seats

  def initialize
    @seats = {
      rows: { min: 0, max: 127 },
      columns: { min: 0, max: 7 }
    }
  end

  def rows
    seats[:rows]
  end

  def rows=(value)
    seats[:rows] = value
  end

  def columns
    seats[:columns]
  end

  def columns=(value)
    seats[:columns] = value
  end

  def to_s
    return nil unless rows[:min] == rows[:max] && columns[:min] == columns[:max]

    "#{rows[:min]},#{columns[:max]}"
  end

  def id
    return nil unless rows[:min] == rows[:max] && columns[:min] == columns[:max]

    rows[:min] * 8 + columns[:max]
  end
end

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

class Instruction
  def self.apply(instruction, seats)
    case instruction
    when 'F' then FInstruction
    when 'B' then BInstruction
    when 'L' then LInstruction
    when 'R' then RInstruction
    end.apply(seats)
  end
end

class FInstruction
  def self.apply(seats)
    value = ((seats.rows[:max] - seats.rows[:min]).to_f / 2).ceil
    seats.rows = { min: seats.rows[:min], max: seats.rows[:max] - value }
    seats
  end
end

class BInstruction
  def self.apply(seats)
    value = ((seats.rows[:max] - seats.rows[:min]).to_f / 2).ceil
    seats.rows = { min: seats.rows[:min] + value, max: seats.rows[:max] }
    seats
  end
end

class LInstruction
  def self.apply(seats)
    value = ((seats.columns[:max] - seats.columns[:min]).to_f / 2).ceil
    seats.columns = { min: seats.columns[:min], max: seats.columns[:max] - value }
    seats
  end
end

class RInstruction
  def self.apply(seats)
    value = ((seats.columns[:max] - seats.columns[:min]).to_f / 2).ceil
    seats.columns = { min: seats.columns[:min] + value, max: seats.columns[:max] }
    seats
  end
end

max_seat_id = -1
INPUT.each do |instructions|
  seat = BoardingPass.new(instructions).seat
  # puts seat.to_s
  max_seat_id = seat.id if seat.id > max_seat_id
end

puts max_seat_id
