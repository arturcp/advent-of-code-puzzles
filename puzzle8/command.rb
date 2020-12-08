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

