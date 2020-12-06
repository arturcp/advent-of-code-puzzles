class FInstruction
  def self.apply(seats)
    value = ((seats.rows[:max] - seats.rows[:min]).to_f / 2).ceil
    seats.rows = { min: seats.rows[:min], max: seats.rows[:max] - value }
    seats
  end
end
