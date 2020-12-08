require_relative './command.rb'

class Acc < Command
  def execute_command(control_variables)
    control_variables.accumulator += self.argument
    control_variables.current_index += 1
  end
end
