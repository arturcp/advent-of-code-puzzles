class DefaultMemoryAddressDecoder
  def self.decode(address, mask)
    [address]
  end
end

class Instruction
  attr_reader :addresses, :value

  def self.parse(instruction, mask, memory_address_decoder = DefaultMemoryAddressDecoder)
    parts = instruction.split(' = ')
    address = parts[0].gsub('mem[', '').gsub(']', '').to_i
    value = parts[1].strip.to_i
    new(memory_address_decoder.decode(address, mask), value)
  end

  def initialize(addresses, value)
    @addresses = addresses
    @value = value
  end
end
