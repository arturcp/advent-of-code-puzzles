require_relative '../input.rb'
require_relative '../instruction.rb'
require_relative '../memory.rb'
require_relative '../mask.rb'

class MemoryAddressDecoder
  def self.decode(address, mask)
    binary = address.to_s(2).rjust(36, '0')
    result = ''
    mask_chars = mask.mask.chars
    binary.chars.each_with_index do |char, index|
      case mask_chars[index]
      when '0'
        result += char
      else
        result += mask_chars[index]
      end
    end

    variations = []
    all_variations(result, variations)
    variations
  end

  def self.all_variations(address, result)
    if !address.include?('X')
      result << address.to_i(2)
      return
    end

    index = address.index('X')
    ['0', '1'].each do |bit|
      clone = address.dup
      clone[index] = bit
      all_variations(clone.to_s, result) unless result.include?(clone.to_i(2))
    end if index != nil
  end
end

class DefaultMask
  def apply(value)
    value
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
    instruction = Instruction.parse(item, last_mask, memory_address_decoder = MemoryAddressDecoder)
    memory.write(instruction, DefaultMask.new)
  end
end

puts memory.sum