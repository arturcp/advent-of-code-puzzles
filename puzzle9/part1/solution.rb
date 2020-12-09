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
  print "#{INPUT[current_index]}..."
  valid = valid?(INPUT[current_index], INPUT.slice(current_index - preamble, preamble))
  puts valid
  current_index += 1
end
