require_relative '../input.rb'

class Map
  attr_reader :map, :current_row, :current_column

  RIGHT_INCREMENT = 3
  DOWN_INCREMENT = 1

  def initialize(map, current_row = 0, current_column = 0)
    @map = map
    @current_row = 0
    @current_column = 0
  end

  def next_move
    @current_column += RIGHT_INCREMENT
    @current_row += DOWN_INCREMENT

    @current_column = current_column % map[0].length

    return unless map[current_row]

    map[current_row][current_column]
  end

  def navigate
    tree_counter = 0
    element = next_move
    while element
      tree_counter += 1 if element == '#'
      element = next_move
    end

    tree_counter
  end
end

puts Map.new(INPUT).navigate