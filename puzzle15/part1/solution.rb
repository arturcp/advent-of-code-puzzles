require_relative '../input.rb'
require 'colorize'

class Game
  def initialize(numbers)
    @numbers = numbers
  end

  def start(nth_turn)
    number = nil
    current_turn = @numbers.length
    spoken_numbers = @numbers.each.with_index.map { |number, index| Number.new(number, index + 1) }
    last_spoken_number = spoken_numbers.last

    (nth_turn - @numbers.length).times do |i|
      current_turn += 1

      print "#{'Turn'.light_blue} #{current_turn.to_s.light_blue}: The last spoken number was #{last_spoken_number.value.to_s.yellow}. "

      if last_spoken_number.how_many_times_it_appeared == 1
        puts "It was spoken only once before, so the current number is #{'0'.yellow}"
        new_number = 0
      else
        puts "It was spoken more than once before, so the current number is #{last_spoken_number.difference_between_two_last_appearances.to_s.yellow}"
        new_number = last_spoken_number.difference_between_two_last_appearances
      end

      number = spoken_numbers.find { |spoken_number| spoken_number.value == new_number }
      if number
        number.spoken_in_turn(current_turn)
      else
        number = Number.new(new_number, current_turn)
        spoken_numbers << number
      end

      last_spoken_number = number
    end

    number.value
  end
end

class Number
  def initialize(number, turn)
    @number = number
    @turns_where_the_number_appear = [turn]
  end

  def spoken_in_turn(turn)
    @turns_where_the_number_appear << turn
  end

  def how_many_times_it_appeared
    @turns_where_the_number_appear.length
  end

  def difference_between_two_last_appearances
    @turns_where_the_number_appear[-1] - @turns_where_the_number_appear[-2]
  end

  def value
    @number
  end
end


game = Game.new(INPUT)
puts game.start(2020)