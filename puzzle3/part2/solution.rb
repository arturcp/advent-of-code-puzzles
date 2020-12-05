require_relative '../input.rb'

class Map
  attr_reader :map, :steps_to_the_right, :steps_down, :current_row, :current_column

  def initialize
    @map = INPUT
  end

  def navigate(steps_to_the_right, steps_down)
    @current_row = 0
    @current_column = 0

    tree_counter = 0
    element = move_to_the_next_position(steps_to_the_right, steps_down)

    while element
      tree_counter += 1 if tree?(element)
      element = move_to_the_next_position(steps_to_the_right, steps_down)
    end

    tree_counter
  end

  private

  def move_to_the_next_position(steps_to_the_right, steps_down)
    @current_column += steps_to_the_right
    @current_row += steps_down

    @current_column = current_column % map[0].length

    return unless map[current_row]

    map[current_row][current_column]
  end

  def tree?(element)
    element == '#'
  end
end

navigator = Map.new

puts [
  navigator.navigate(1, 1),
  navigator.navigate(3, 1),
  navigator.navigate(5, 1),
  navigator.navigate(7, 1),
  navigator.navigate(1, 2)
].reduce(1, :*)
