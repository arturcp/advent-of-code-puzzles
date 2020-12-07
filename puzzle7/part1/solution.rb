require_relative '../input.rb'
require_relative '../rule.rb'
require_relative '../eligible_content.rb'

rules = INPUT.map do |rule|
  Rule.build(rule)
end

def fetch(item, checked_rules, rules)
  eligible_rules = rules.select { |rule| !checked_rules.include?(rule) && rule.accept?(item) }

  eligible_rules.each do |rule|
    checked_rules = fetch(rule.name, checked_rules + [rule], rules) unless checked_rules.include?(rule)
  end

  checked_rules.uniq
end

checked_rules = []

eligible_rules = fetch('shiny gold', checked_rules, rules)

puts eligible_rules.length