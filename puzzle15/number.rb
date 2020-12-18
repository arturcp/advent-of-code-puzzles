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