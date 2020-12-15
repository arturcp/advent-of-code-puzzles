require_relative '../input.rb'
require 'colorize'

class Map
  attr_reader :iteration

  def initialize(strings_map)
    @map = []
    strings_map.each_with_index do |row, index|
      @map[index] = row.chars
    end
  end

  def play
    @iteration = 0
    while status = next_turn; end

    count_occupied_seats
  end

  def next_turn
    @iteration += 1
    new_map = clone

    map.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        next if column == '.'

        occupied_adjacent_seats = calculate_occupied_adjacent_seats(row_index, column_index)

        if column == 'L' && occupied_adjacent_seats == 0
          new_map[row_index][column_index] = '#'
        elsif column == '#' && occupied_adjacent_seats >= 4
          new_map[row_index][column_index] = 'L'
        end
      end
    end

    if map_changed?(new_map)
      @map = new_map
      true
    else
      false
    end
  end

  def show(highlight: [], map: @map)
    map.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        if highlight.length > 0 && row_index == highlight[0] && column_index == highlight[1]
          print "#{column} ".yellow
        else
          print "#{column} "
        end
      end

      puts ''
    end
  end

  private

  attr_reader :map

  def calculate_occupied_adjacent_seats(row, column)
    occupied = 0

    occupied += 1 if occupied?(row - 1, column)
    occupied += 1 if occupied?(row + 1, column)
    occupied += 1 if occupied?(row, column - 1)
    occupied += 1 if occupied?(row, column + 1)

    # Diagonal
    occupied += 1 if occupied?(row - 1, column - 1)
    occupied += 1 if occupied?(row - 1, column + 1)
    occupied += 1 if occupied?(row + 1, column - 1)
    occupied += 1 if occupied?(row + 1, column + 1)

    occupied
  end

  def occupied?(row, column)
    return false if row < 0 || column < 0 || row > map.length - 1 || column > map[0].length - 1

    map[row][column] == '#'
  end

  def clone
    new_map = []
    map.each_with_index do |row, row_index|
      new_map << []
      row.each_with_index do |column, column_index|
        new_map[row_index] << column
      end
    end

    new_map
  end

  def map_changed?(new_map)
    new_map != map
  end

  def count_occupied_seats
    map_to_string(map).count('#')
  end

  def map_to_string(map)
    map.map { |row| row.join('') }.join('')
  end
end


map = Map.new(INPUT)
puts ''
puts map.play
# map.show

