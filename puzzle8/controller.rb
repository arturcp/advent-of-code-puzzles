require_relative './control_variables.rb'

class Controller
  attr_reader :commands

  def initialize(commands)
    @commands = commands
  end

  def execute_instructions
    control_variables = ControlVariables.new

    current_command = commands[control_variables.current_index]

    while !current_command.executed?
      current_command.run(control_variables)
      current_command = commands[control_variables.current_index]
    end

    control_variables
  end
end
