require 'colorize'

class Game
  def initialize(numbers, log_offset: 1)
    @numbers = numbers
    @log_offset = log_offset
  end

  def start(nth_turn)
    number = nil
    current_turn = @numbers.length
    # This is a cool optimization. I was using an array before (check the
    # last commit to see it. With a high number of turns, the list is too big
    # and it takes time to run 3000000 iterations. The hash is quicker)
    spoken_numbers = {}
    @numbers.each.with_index { |number, index| spoken_numbers[number] = Number.new(number, index + 1) }
    last_spoken_number = spoken_numbers[@numbers.last]

    (nth_turn - @numbers.length).times do |i|
      current_turn += 1

      # print_log current_turn, "#{'Turn'.light_blue} #{current_turn.to_s.light_blue}: The last spoken number was #{last_spoken_number.value.to_s.yellow}. "

      if last_spoken_number.how_many_times_it_appeared == 1
        # puts_log current_turn, "It was spoken only once before, so the current number is #{'0'.yellow}"
        new_number = 0
      else
        # puts_log current_turn, "It was spoken more than once before, so the current number is #{last_spoken_number.difference_between_two_last_appearances.to_s.yellow}"
        new_number = last_spoken_number.difference_between_two_last_appearances
      end

      number = spoken_numbers[new_number]
      if number
        number.spoken_in_turn(current_turn)
      else
        number = Number.new(new_number, current_turn)
        spoken_numbers[new_number] = number
      end

      last_spoken_number = number
    end

    number.value
  end

  private

  def print_log(turn, message)
    return unless turn % @log_offset == 0
    print message
  end

  def puts_log(turn, message)
    return unless turn % @log_offset == 0
    puts message
  end
end
