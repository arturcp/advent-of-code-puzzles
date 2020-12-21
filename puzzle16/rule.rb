class Rule
  attr_reader :name

  def initialize(rule_text)
    parts = rule_text.split(': ')
    @name = parts[0]
    @validation_rules = extract_rules(parts[1])
  end

  def valid?(value)
    @validation_rules.each do |rule|
      return true if value >= rule[:min] && value <= rule[:max]
    end

    false
  end

  private

  def extract_rules(rules_text)
    rules = []
    parts = rules_text.split(' or ')
    parts.each do |part|
      min, max = part.split('-')
      rules << { min: min.to_i, max: max.to_i }
    end
    rules
  end
end

