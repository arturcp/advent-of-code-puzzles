class Mask
  attr_reader :mask

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

