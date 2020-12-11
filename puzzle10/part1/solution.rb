require_relative '../input.rb'

joltages = INPUT.sort
device_joltage = joltages.last + 3

current_jolts = 0

differences = {
  '1' => 0,
  '2' => 0,
  '3' => 1
}

joltages.each do |joltage|
  difference = joltage - current_jolts
  differences[difference.to_s] += 1
  current_jolts = joltage
end

puts differences.inspect

puts ''
puts 'Result: '
puts differences['1'] * differences['3']