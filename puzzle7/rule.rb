class Rule
  def self.build(rule_text)
    rule_text.gsub!('.', '')
    parts = rule_text.split(' contain ')
    name = parts[0].gsub(' bags', '')
    eligible_contents = parts[1].split(',').map do |eligible_content|
      next if eligible_content == 'no other bags'

      parts = eligible_content.strip.split(' ')
      { quantity: parts.shift.to_i, item: parts.join(' ') }
    end.compact

    new(name, eligible_contents)
  end

  attr_reader :name, :eligible_contents

  def initialize(name, eligible_contents)
    @name = name
    @eligible_contents = eligible_contents.map do |content|
      EligibleContent.new(**content)
    end
  end

  def accept?(item)
    !eligible_contents.find { |content| content.item == item }.nil?
  end

  def to_s
    "Name: #{name}, eligible_contents: #{eligible_contents.map(&:to_s)}"
  end
end
