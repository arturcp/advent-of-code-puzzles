class LInstruction
  def self.apply(seats)
    value = ((seats.columns[:max] - seats.columns[:min]).to_f / 2).ceil
    seats.columns = { min: seats.columns[:min], max: seats.columns[:max] - value }
    seats
  end
end
