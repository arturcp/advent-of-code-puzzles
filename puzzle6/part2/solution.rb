require_relative '../input.rb'

def count_answers_where_everyone_said_yes(group_answers, people_in_the_group)
  counter = 0
  group_answers.keys.each do |key|
    counter += 1 if group_answers[key] == people_in_the_group
  end
  counter
end

all_answers = (INPUT + [''])
group_answers = {}
answers_with_yes = []
people_in_the_group = 0
all_answers.each do |answers|
  if answers.empty?
    answers_with_yes << count_answers_where_everyone_said_yes(group_answers, people_in_the_group)
    group_answers = {}
    people_in_the_group = 0
  else
    people_in_the_group += 1
    answers.chars.each do |answer|
      group_answers[answer] ||= 0
      group_answers[answer] += 1
    end
  end
end

puts answers_with_yes.reduce(0, &:+)