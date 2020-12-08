require_relative '../input.rb'
require_relative '../command_factory.rb'
require_relative '../controller.rb'

DEBUG = true

class CommandsChanger
  attr_reader :commands

  def initialize(commands)
    @commands = commands
  end

  def execute
    print_commands(commands)

    control_variables = ControlVariables.new
    control_variables.infinite_loop = true
    index_to_change = 0

    while control_variables.infinite_loop && index_to_change < commands.length
      cloned_commands = change_commands(index_to_change)
      if cloned_commands
        print_commands(cloned_commands)
        control_variables = Controller.new(cloned_commands).execute_instructions
      end
      index_to_change += 1
    end

    control_variables
  end

  private

  def change_commands(index_to_change)
    cloned_commands = commands.dup
    cloned_commands.each { |command| command.reset_status }
    command = cloned_commands[index_to_change]
    return nil if command.is_a?(Acc)

    puts_log('')
    print_log "Changing line #{index_to_change} "
    if command.is_a?(Jmp)
      puts_log "from Jmp #{command.argument} to Nop #{command.argument}"
      cloned_commands[index_to_change] = Nop.new(command.instruction.gsub('jmp', 'nop'))
    elsif command.is_a?(Nop)
      puts_log "from Nop #{command.argument} to Jmp #{command.argument}"
      cloned_commands[index_to_change] = Jmp.new(command.instruction.gsub('nop', 'jmp'))
    end

    cloned_commands
  end

  def print_log(text)
    return unless DEBUG

    print text
  end

  def puts_log(text)
    return unless DEBUG

    puts text
  end

  def print_commands(commands)
    return unless DEBUG

    puts ""
    puts "----------"
    commands.each { |command| puts command.instruction }
    puts "----------"
    puts ""
  end
end

commands = INPUT.map { |instruction| CommandFactory.build(instruction) }
commands_changer = CommandsChanger.new(commands)
puts commands_changer.execute
