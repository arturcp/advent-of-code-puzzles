require_relative '../input.rb'

all_answers = (INPUT + [''])
group_answers = {}
answers_with_yes = []
all_answers.each do |answers|
  if answers.empty?
    answers_with_yes << group_answers.keys.count
    group_answers = {}
  else
    answers.chars.each { |answer| group_answers[answer] = 1 }
  end
end

puts answers_with_yes.reduce(0, &:+)