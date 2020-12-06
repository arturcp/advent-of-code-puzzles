class BInstruction
  def self.apply(seats)
    value = ((seats.rows[:max] - seats.rows[:min]).to_f / 2).ceil
    seats.rows = { min: seats.rows[:min] + value, max: seats.rows[:max] }
    seats
  end
end
