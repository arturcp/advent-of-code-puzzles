require 'byebug'
require_relative '../input.rb'

def multiplied_pair_that_adds_up_to(total, list)
  INPUT.each do |number|
    remaining = total - number
    if INPUT.include?(remaining)
      return [number, remaining]
    end
  end

  []
end

INPUT.each_with_index do |number, index|
  remaining = 2020 - number
  result = multiplied_pair_that_adds_up_to(remaining, INPUT.slice(index + 1, INPUT.length - index - 1))
  if !result.empty?
    puts number * result.first * result.last
    return
  end
end

# puts multiplied_pair_that_adds_up_to(2020)