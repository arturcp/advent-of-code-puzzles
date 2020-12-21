require_relative '../input.rb'
require_relative '../rule.rb'

require 'colorize'

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
hash_of_invalid_attributes = {}
# hash_of_possible_attributes = {}

nearby_tickets.each_with_index do |ticket, ticket_index|
  puts ''
  puts "Ticket ##{ticket_index}: #{ticket}"
  puts "----------------------------"
  ticket.split(',').map(&:to_i).each_with_index do |ticket_number, ticket_number_index|
    valid = false
    hash_of_invalid_attributes[ticket_number_index] ||= []

    puts "\nNumber #{ticket_number}..."

    invalid_rules = []

    rules.each_with_index do |rule, rule_index|
      rule_valid = rule.valid?(ticket_number)
      puts " #{rule_valid ? 'true'.green : 'false'.red} - #{rule.inspect}"
      valid = true if rule_valid
      invalid_rules << rule.name if !rule_valid && !invalid_rules.include?(rule.name)
      # hash_of_possible_attributes[ticket_number_index] ||= []
      # hash_of_possible_attributes[ticket_number_index] << rule.name if rule_valid && !hash_of_possible_attributes[ticket_number_index].include?(rule.name)
    end

    if !valid
      puts "ignoring ticket #{ticket}"
      invalid_numbers << ticket_number
    else
      hash_of_invalid_attributes[ticket_number_index] += invalid_rules
      hash_of_invalid_attributes[ticket_number_index].uniq!
    end
  end
end

valid_tickets = nearby_tickets.select do |ticket|
  (ticket.split(',').map(&:to_i) & invalid_numbers).length == 0
end

puts ''
puts "Valid tickets:"
puts valid_tickets.inspect

puts ''
puts "hash of invalid attributes:"
puts hash_of_invalid_attributes.inspect

class AttributesDiscover
  attr_reader :rules_position, :rules

  def initialize(rules)
    @rules_position = {}
    @rules = rules.map(&:name)
  end

  def discover(hash)
    rules_with_one_valid_option = hash.select { |k, v| (rules - v).length == 1 }
    return if rules_with_one_valid_option.empty?

    list_of_rules_to_remove = []
    rules_with_one_valid_option.each do |key, list_of_invalid_rules|
      list_of_valid_rules = rules - list_of_invalid_rules
      list_of_rules_to_remove << list_of_valid_rules.first unless list_of_rules_to_remove.include?(list_of_rules_to_remove)
      rules_position[list_of_valid_rules.first] = key.to_i
      hash[key] = []
    end

    hash.each do |k, v|
      unless hash[k].empty?
        hash[k] += list_of_rules_to_remove
        hash[k].uniq!
      end
    end

    discover(hash)
  end
end

discoverer = AttributesDiscover.new(rules)
discoverer.discover(hash_of_invalid_attributes)

# puts 'other hash'
# puts hash_of_possible_attributes.inspect


hash = discoverer.rules_position
discovered_rules = hash.keys

rules_names = rules.map(&:name)
rule = (rules_names - discovered_rules).first
rules_names.length.times do |i|
  next if !hash[rules_names[i]].nil?
  hash[rules_names[i]] = i
end

puts ''
puts 'Result:'
puts hash.inspect


puts ''

departures = rules_names.select do |rule_name|
  rule_name.include?('departure')
end

result = 1
your_ticket = your_ticket.first.split(',').map(&:to_i)
departures.each do |departure|
  index = hash[departure]
  result *= your_ticket[index]
end

puts result