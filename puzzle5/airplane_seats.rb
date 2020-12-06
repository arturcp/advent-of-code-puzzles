class AirplaneSeats
  attr_accessor :seats

  def initialize
    @seats = {
      rows: { min: 0, max: 127 },
      columns: { min: 0, max: 7 }
    }
  end

  def rows
    seats[:rows]
  end

  def rows=(value)
    seats[:rows] = value
  end

  def columns
    seats[:columns]
  end

  def columns=(value)
    seats[:columns] = value
  end

  def to_s
    return nil unless rows[:min] == rows[:max] && columns[:min] == columns[:max]

    "#{rows[:min]},#{columns[:max]}"
  end

  def id
    return nil unless rows[:min] == rows[:max] && columns[:min] == columns[:max]

    rows[:min] * 8 + columns[:max]
  end
end
