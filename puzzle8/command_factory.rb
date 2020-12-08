require_relative './acc.rb'
require_relative './jmp.rb'
require_relative './nop.rb'

class CommandFactory
  def self.build(instruction)
    operation = instruction.slice(0, 3)
    case operation
    when 'acc' then Acc
    when 'jmp' then Jmp
    when 'nop' then Nop
    end.new(instruction)
  end
end
