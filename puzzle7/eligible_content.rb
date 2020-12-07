class EligibleContent
  attr_reader :quantity, :item

  def initialize(quantity:, item:)
    @quantity = quantity
    @item = item.gsub(' bags', '').gsub(' bag', '')
  end

  def to_s
    "Quantity: #{quantity}, item: #{item}"
  end
end
