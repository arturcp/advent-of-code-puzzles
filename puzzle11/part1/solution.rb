require_relative '../input.rb'
require 'byebug'

class Mask
  def initialize(mask)
    @mask = mask
  end

  def apply(number)
    binary = number.to_s(2).rjust(36, '0')
    result = ''
    binary.chars.each_with_index do |char, index|
      result += @mask[index] == 'X' ? char : @mask[index]
    end
    result.to_i(2)
  end
end

class Instruction
  attr_reader :address, :value

  def self.parse(instruction)
    parts = instruction.split(' = ')
    address = parts[0].gsub('mem[', '').gsub(']', '').to_i
    value = parts[1].strip.to_i
    new(address, value)
  end

  def initialize(address, value)
    @address = address
    @value = value
  end
end

class Memory
  def initialize
    @hash = {}
  end

  def write(instruction, mask)
    @hash[instruction.address] = mask.apply(instruction.value)
  end

  def sum
    @hash.reduce(0) { |acc, (k, v)| acc + v }
  end
end

list = INPUT

last_mask = nil
memory = Memory.new

list.each do |item|
  if item.include?('mask')
    mask = item.split(' = ')[1]
    last_mask = Mask.new(mask)
  else
    instruction = Instruction.parse(item)
    memory.write(instruction, last_mask)
  end
end

puts memory.sum