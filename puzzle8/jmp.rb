require_relative './command.rb'

class Jmp < Command
  OPERATION = 'jmp'

  def execute_command(control_variables)
    control_variables.current_index += argument
  end
end
