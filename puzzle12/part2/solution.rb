require_relative '../input.rb'

class SeaObject
  attr_accessor :east_west, :north_south

  def initialize
    reset
  end
end

class Ship < SeaObject
  def reset
    @east_west = 0
    @north_south = 0
  end
end

class Waypoint < SeaObject
  def reset
    @east_west = 10
    @north_south = 1
  end
end

class Navigation
  attr_reader :waypoint, :ship

  def initialize
    @ship = Ship.new
    @waypoint = Waypoint.new
  end

  def calculate_manhattan_distance(instructions)
    reset_attributes
    instructions.each do |instruction|
      execute(instruction)
      puts "#{instruction}"
      puts "SHIP: #E/W: #{ship.east_west} - N/S: #{ship.north_south}"
      puts "Waypoint: #E/W: #{waypoint.east_west} - N/S: #{waypoint.north_south}"
    end

    ship.east_west.abs + ship.north_south.abs
  end

  def change_east_west(value)
    ship.east_west += value
  end

  def change_north_south(value)
    ship.north_south += value
  end

  private

  attr_reader :east_west, :north_south

  def reset_attributes
    ship.reset
    waypoint.reset
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
    east_west_value = navigation.waypoint.east_west * value
    north_south_value = navigation.waypoint.north_south * value

    navigation.change_east_west(east_west_value)
    navigation.change_north_south(north_south_value)
  end

  def move_north(value)
    navigation.waypoint.north_south += value
  end

  def move_south(value)
    navigation.waypoint.north_south -= value
  end

  def move_east(value)
    navigation.waypoint.east_west += value
  end

  def move_west(value)
    navigation.waypoint.east_west -= value
  end

  def turn_left(value)
    change_direction(LEFT_DIRECTION)
  end

  def turn_right(value)
    change_direction(RIGHT_DIRECTION)
  end

  def change_direction(direction_constant)
    horizontal_direction = navigation.waypoint.east_west > 0 ? :east : :west
    vertical_direction = navigation.waypoint.north_south > 0 ? :north : :south

    new_horizontal_direction = direction_constant[horizontal_direction][value]
    new_horizontal_value = navigation.waypoint.east_west.abs
    if [:south, :west].include?(new_horizontal_direction)
      new_horizontal_value *= -1
    end

    new_vertical_direction = direction_constant[vertical_direction][value]
    new_vertical_value = navigation.waypoint.north_south.abs
    if [:south, :west].include?(new_vertical_direction)
      new_vertical_value *= -1
    end

    if [:east, :west].include?(new_horizontal_direction)
      navigation.waypoint.east_west = new_horizontal_value
    else
      navigation.waypoint.north_south = new_horizontal_value
    end

    if [:east, :west].include?(new_vertical_direction)
      navigation.waypoint.east_west = new_vertical_value
    else
      navigation.waypoint.north_south = new_vertical_value
    end
  end
end

puts Navigation.new.calculate_manhattan_distance(INPUT)
