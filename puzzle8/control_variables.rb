class ControlVariables
  attr_accessor :current_index, :accumulator, :infinite_loop

  def initialize
    @current_index = 0
    @accumulator = 0
    @infinite_loop = false
  end

  def to_s
    "Index: #{current_index}, Accumulator: #{accumulator}, Infinite Loop: #{infinite_loop}"
  end
end

