require_relative '../input.rb'

class Rule
  def self.from(text)
    parts = text.split(' ')
    range = parts[0].split('-')
    new(range[0], range[1], parts[1])
  end

  attr_reader :first_position, :second_position, :letter

  def initialize(first_position, second_position, letter)
    @first_position = first_position.to_i
    @second_position = second_position.to_i
    @letter = letter
  end

  def valid?(password)
    password = password.strip
    first_letter = password[first_position - 1]
    second_letter = password[second_position - 1]
    (first_letter == letter) ^ (second_letter == letter)
  end
end

counter = 0
INPUT.each do |input|
  parts = input.split(':')
  counter += 1 if Rule.from(parts[0]).valid?(parts[1])
end

puts counter