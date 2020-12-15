require_relative '../input.rb'
require_relative '../instruction.rb'
require_relative '../memory.rb'
require_relative '../mask.rb'

list = INPUT

last_mask = nil
memory = Memory.new

list.each do |item|
  if item.include?('mask')
    mask = item.split(' = ')[1]
    last_mask = Mask.new(mask)
  else
    instruction = Instruction.parse(item, mask)
    memory.write(instruction, last_mask)
  end
end

puts memory.sum