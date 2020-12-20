require_relative '../input.rb'
require_relative '../rule.rb'

data = []

accumulator = []

(INPUT + ['']).each do |line|
  if line.empty?
    data << accumulator
    accumulator = []
  else
    accumulator << line
  end
end

rules_text = data[0]
rules = rules_text.map { |rule_text| Rule.new(rule_text) }

your_ticket = data[1]
your_ticket.shift

nearby_tickets = data[2]
nearby_tickets.shift

invalid_numbers = []
nearby_tickets.each do |ticket|
  ticket.split(',').map(&:to_i).each_with_index do |ticket_number, ticket_number_index|
    valid = false

    rules.each do |rule|
      break if valid
      valid = rule.valid?(ticket_number)
    end
    invalid_numbers << ticket_number if !valid
  end
end

puts invalid_numbers.inspect
puts ''
puts invalid_numbers.reduce(0, :+)