require_relative '../input.rb'

class Rule
  def self.from(text)
    parts = text.split(' ')
    range = parts[0].split('-')
    new(range[0], range[1], parts[1])
  end

  attr_reader :min_occurencies, :max_occurencies, :letter

  def initialize(min_occurencies, max_occurencies, letter)
    @min_occurencies = min_occurencies.to_i
    @max_occurencies = max_occurencies.to_i
    @letter = letter
  end

  def valid?(password)
    password = password.strip
    occurrencies = password.scan(/(?=#{letter})/).count
    occurrencies >= min_occurencies && occurrencies <= max_occurencies
  end
end

counter = 0
INPUT.each do |input|
  parts = input.split(':')
  counter += 1 if Rule.from(parts[0]).valid?(parts[1])
end

puts counter