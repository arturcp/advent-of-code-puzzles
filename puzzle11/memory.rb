class Memory
  def initialize
    @hash = {}
  end

  def write(instruction, mask)
    Array(instruction&.addresses).each do |address|
      @hash[address] = mask.apply(instruction.value)
    end
  end

  def sum
    @hash.reduce(0) { |acc, (k, v)| acc + v }
  end
end
