require_relative '../input.rb'
require 'byebug'
require 'active_support/core_ext/numeric/conversions'

# This is a Chinese reminder theorem

timestamp = INPUT[0].to_i
bus_lines = INPUT[1].split(',')

rules = bus_lines.each_with_index.map do |line, index|
  { id: line.to_i, offset: index } if line != 'x'
end.compact

puts rules.inspect

current_timestamp = timestamp
# least commom multiplier
lcm = 1
rules.each do |rule|
  while (current_timestamp + rule[:offset]) % rule[:id] != 0
    current_timestamp += lcm
  end

  lcm *= rule[:id]
end


puts ''
puts current_timestamp
