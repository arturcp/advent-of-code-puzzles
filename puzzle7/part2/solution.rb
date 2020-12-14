require_relative '../input.rb'
require_relative '../rule.rb'
require_relative '../eligible_content.rb'

bags = INPUT.each_with_object({}) do |rule, hash|
  object = Rule.build(rule)
  hash[object.name] = object
end

my_bag = bags['shiny gold']

bag_counter = 0

def count_inner_bags(bags, bag, multiplier: 1, total: 0)
  if bag.eligible_contents.length == 0
    total
  else
    bag.eligible_contents.each do |content|
      total += content.quantity * multiplier
      print " + #{content.quantity * multiplier}"
      total = count_inner_bags(bags, bags[content.item], multiplier: content.quantity * multiplier, total: total)
    end

    total
  end
end


print '0'
value = count_inner_bags(bags, my_bag)
print " = #{value}"
puts ''