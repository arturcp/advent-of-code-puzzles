require_relative '../input.rb'
require 'colorize'
require 'byebug'

class Map
  def initialize(strings_map)
    @map = []
    strings_map.each_with_index do |row, index|
      @map[index] = row.chars
    end
  end

  def play
    while status = next_turn; end

    count_occupied_seats
  end

  def next_turn
    new_map = clone

    map.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        next if column == '.'

        occupied_adjacent_seats = calculate_occupied_adjacent_seats(row_index, column_index)

        if column == 'L' && occupied_adjacent_seats == 0
          new_map[row_index][column_index] = '#'
        elsif column == '#' && occupied_adjacent_seats >= 5
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

  def main_diagonal_down_seat(row, column)
    difference = column - row
    (row + 1).upto(map.length).each do |i|
      j = i + difference
      return 0 if i > map.length - 1 || j > map[0].length

      seat = map[i][j]
      next if seat == '.'
      return seat == '#' ? 1 : 0
    end

    0
  end

  def main_diagonal_up_seat(row, column)
    difference = column - row
    (row - 1).downto(0).each do |i|
      j = i + difference
      return 0 if i < 0 || j < 0

      seat = map[i][j]
      next if seat == '.'
      return seat == '#' ? 1 : 0
    end

    0
  end

  def secondary_diagonal_down_seat(row, column)
    sum = column + row
    (row + 1).upto(map.length - 1).each do |i|
      j = sum - i
      return 0 if i > map.length - 1 || j < 0

      seat = map[i][j]
      next if seat == '.'
      return seat == '#' ? 1 : 0
    end

    0
  end

  def secondary_diagonal_up_seat(row, column)
    sum = column + row
    (row - 1).downto(0).each do |i|
      j = sum - i
      return 0 if i < 0 || j > map[0].length - 1

      seat = map[i][j]
      next if seat == '.'
      return seat == '#' ? 1 : 0
    end

    0
  end

  def up_seat(row, column)
    (row - 1).downto(0).each do |i|
      seat = map[i][column]
      next if seat == '.'
      return seat == '#' ? 1 : 0
    end

    0
  end

  def down_seat(row, column)
    (row + 1).upto(map.length - 1).each do |i|
      seat = map[i][column]
      next if seat == '.'
      return seat == '#' ? 1 : 0
    end

    0
  end

  def left_seat(row, column)
    (column - 1).downto(0).each do |j|
      seat = map[row][j]
      next if seat == '.'
      return seat == '#' ? 1 : 0
    end

    0
  end

  def right_seat(row, column)
    (column + 1).upto(map[0].length - 1).each do |j|
      seat = map[row][j]
      next if seat == '.'
      return seat == '#' ? 1 : 0
    end

    0
  end

  def calculate_occupied_adjacent_seats(row, column)
    [
      up_seat(row, column),
      down_seat(row, column),
      left_seat(row, column),
      right_seat(row, column),
      main_diagonal_up_seat(row, column),
      main_diagonal_down_seat(row, column),
      secondary_diagonal_up_seat(row, column),
      secondary_diagonal_down_seat(row, column)
    ].reduce(0, :+)
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
map.show
puts '--------------------'
puts map.play
