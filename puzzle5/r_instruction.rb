class RInstruction
  def self.apply(seats)
    value = ((seats.columns[:max] - seats.columns[:min]).to_f / 2).ceil
    seats.columns = { min: seats.columns[:min] + value, max: seats.columns[:max] }
    seats
  end
end
