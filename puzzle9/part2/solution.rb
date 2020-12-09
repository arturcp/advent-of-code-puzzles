require_relative '../input.rb'

preamble = 25
current_index = preamble

def valid?(number, list)
  valid = false
  index = 0

  loop do
    item = list[index]
    remaining = number - item
    next if remaining == number
    valid = list.include?(remaining)

    index += 1

    break if valid || index == list.length
  end

  valid
end

valid = true
while current_index < INPUT.length && valid
  valid = valid?(INPUT[current_index], INPUT.slice(current_index - preamble, preamble))
  current_index += 1
end

invalid_number = INPUT[current_index - 1]
puts "Invalid number: #{invalid_number}"

valid_list = INPUT.slice(0, current_index + 1)

def numbers_that_add_to(number, list)
  current_index = 0
  sum = 0
  while sum < number && current_index < list.length
    sum += list[current_index]
    current_index += 1
  end

  sum == number ? list.slice(0, current_index) : []
end

current_index = 0
result = []
while result.empty?
  result = numbers_that_add_to(invalid_number, valid_list.slice(current_index, valid_list.length))
  current_index += 1
end

print "List of contiguous set of numbers that add up to #{invalid_number}: "
puts result.inspect

result = result.sort

puts "Sum: #{result.first + result.last}"