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
