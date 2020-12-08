require_relative './command.rb'

class Jmp < Command
  def execute_command(control_variables)
    control_variables.current_index += self.argument
  end
end
