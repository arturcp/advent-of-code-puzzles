require_relative '../input.rb'

timestamp = INPUT[0].to_i
bus_lines = INPUT[1].split(',').select { |bus_line| bus_line != 'x' }.map(&:to_i)

bus_found = false
current_timestamp = timestamp
while !bus_found
  eligible_lines = bus_lines.select { |bus_line| timestamp % bus_line == 0 }
  if eligible_lines.length > 0
    bus_found = true
    puts 'Bus lines:'
    puts eligible_lines.inspect
    puts "timestamp: #{current_timestamp}"
    puts "answer: #{(timestamp - current_timestamp) * eligible_lines.first}"
  else
    timestamp += 1
  end
end

