require_relative '../input.rb'

class Command
  attr_reader :operation, :argument, :status

  def initialize(instruction)
    @operation, @argument = instruction.split(' ')
    @argument = argument.to_i
    @status = :pending
  end

  def run(control_variables)
    execute_command(control_variables)
    @status = :executed
  end

  def executed?
    status != :pending
  end
end

class Acc < Command
  def execute_command(control_variables)
    control_variables.accumulator += self.argument
    control_variables.current_index += 1
  end
end

class Nop < Command
  def execute_command(control_variables)
    control_variables.current_index += 1
  end
end

class Jmp < Command
  def execute_command(control_variables)
    control_variables.current_index += self.argument
  end
end

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

class ControlVariables
  attr_accessor :current_index, :accumulator

  def initialize
    @current_index = 0
    @accumulator = 0
  end
end

class Controller
  attr_reader :commands

  def initialize
    @commands = INPUT.map { |instruction| CommandFactory.build(instruction) }
  end

  def execute_instructions
    control_variables = ControlVariables.new

    current_command = commands[control_variables.current_index]

    while !current_command.executed?
      current_command.run(control_variables)
      current_command = commands[control_variables.current_index]
    end

    control_variables.accumulator
  end
end

puts Controller.new.execute_instructions
