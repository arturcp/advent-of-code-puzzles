require_relative '../input.rb'

class Navigation
  attr_reader :current_direction

  def initialize
    reset_attributes
  end

  def calculate_manhattan_distance(instructions)
    reset_attributes
    instructions.each do |instruction|
      execute(instruction)
      puts "#{instruction} - #E/W: #{east_west} - N/S: #{north_south}"
    end

    east_west.abs + north_south.abs
  end

  def change_direction(direction)
    raise unless %i(east west north south).include?(direction)
    @current_direction = direction
  end

  def change_east_west(value)
    @east_west += value
  end

  def change_north_south(value)
    @north_south += value
  end

  private

  attr_reader :east_west, :north_south

  def reset_attributes
    @east_west = 0
    @north_south = 0
    @current_direction = :east
  end

  def execute(instruction)
    direction = instruction[0]
    value = instruction.slice(1, instruction.length - 1).to_i

    Instruction.new(self, direction, value).execute
  end
end

class Instruction
  LEFT_DIRECTION = {
    east: {
      0 => :east,
      90 => :north,
      180 => :west,
      270 => :south,
      360 => :east
    },
    west: {
      0 => :west,
      90 => :south,
      180 => :east,
      270 => :north,
      360 => :west
    },
    north: {
      0 => :north,
      90 => :west,
      180 => :south,
      270 => :east,
      360 => :north
    },
    south: {
      0 => :south,
      90 => :east,
      180 => :north,
      270 => :west,
      360 => :south
    }
  }.freeze

  RIGHT_DIRECTION = {
    east: {
      0 => :east,
      90 => :south,
      180 => :west,
      270 => :north,
      360 => :east
    },
    west: {
      0 => :west,
      90 => :north,
      180 => :east,
      270 => :south,
      360 => :west
    },
    north: {
      0 => :north,
      90 => :east,
      180 => :south,
      270 => :west,
      360 => :north
    },
    south: {
      0 => :south,
      90 => :west,
      180 => :north,
      270 => :east,
      360 => :south
    }
  }.freeze

  def initialize(navigation, direction, value)
    @navigation = navigation
    @direction = direction
    @value = value
  end

  def execute
    case direction
    when 'F'
      move_forward(value)
    when 'N'
      move_north(value)
    when 'S'
      move_south(value)
    when 'E'
      move_east(value)
    when 'W'
      move_west(value)
    when 'L'
      turn_left(value)
    when 'R'
      turn_right(value)
    end
  end

  private

  attr_reader :direction, :value, :navigation

  def move_forward(value)
    if navigation.current_direction == :east
      navigation.change_east_west(value)
    elsif navigation.current_direction == :west
      navigation.change_east_west(-1 * value)
    elsif navigation.current_direction == :north
      navigation.change_north_south(value)
    elsif navigation.current_direction == :south
      navigation.change_north_south(-1 * value)
    end
  end

  def move_north(value)
    navigation.change_north_south(value)
  end

  def move_south(value)
    navigation.change_north_south(-1 * value)
  end

  def move_east(value)
    navigation.change_east_west(value)
  end

  def move_west(value)
    navigation.change_east_west(-1 * value)
  end

  def turn_left(value)
    new_direction = LEFT_DIRECTION[navigation.current_direction][value]
    navigation.change_direction(new_direction)
  end

  def turn_right(value)
    new_direction = RIGHT_DIRECTION[navigation.current_direction][value]
    navigation.change_direction(new_direction)
  end
end

puts Navigation.new.calculate_manhattan_distance(INPUT)
