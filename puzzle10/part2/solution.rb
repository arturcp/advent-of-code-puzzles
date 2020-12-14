require_relative '../input.rb'
require 'byebug'

class Combination
  attr_reader :list, :cache

  def initialize
    @list = [0] + INPUT.sort
    @list << (@list.last + 3)
    @cache = {}
  end

  def number_of_combinations(current_joltage)
    if current_joltage == list.last
      1
    elsif @cache[current_joltage]
      @cache[current_joltage]
    else
      valid_joltages = list.select { |joltage| joltage > current_joltage && joltage - current_joltage <= 3 }
      total = valid_joltages.reduce(0) { |acc, joltage| acc + number_of_combinations(joltage) }
      @cache[current_joltage] = total
      total
    end
  end

  # Another way of solving the same problem
  def number_of_combinations2(pos)
    if pos == list.length - 1
      1
    elsif @cache[pos] != nil
      @cache[pos]
    else
      total = 0
      (pos + 1..list.length - 1).each do |index|
        if list[index] - list[pos] <= 3
          total += number_of_combinations2(index)
        end
      end

      @cache[pos] = total
      total
    end
  end
end

combinations = Combination.new
puts combinations.number_of_combinations(combinations.list[0])
puts combinations.number_of_combinations2(0)
