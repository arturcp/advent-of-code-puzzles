class Command
  attr_reader :operation, :argument, :status, :instruction

  def initialize(instruction)
    @instruction = instruction
    @operation = self.class::OPERATION
    @argument = instruction.split(' ')[1]
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

  def reset_status
    @status = :pending
  end
end

