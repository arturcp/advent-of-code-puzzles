require_relative './command.rb'

class Nop < Command
  def execute_command(control_variables)
    control_variables.current_index += 1
  end
end
