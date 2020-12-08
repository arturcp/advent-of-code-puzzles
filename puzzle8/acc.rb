require_relative './command.rb'

class Acc < Command
  OPERATION = 'acc'

  def execute_command(control_variables)
    control_variables.accumulator += argument
    control_variables.current_index += 1
  end
end
