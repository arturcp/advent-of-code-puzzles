require_relative '../input.rb'

INPUT.each do |number|
  remaining = 2020 - number
  if INPUT.include?(remaining)
    puts number * remaining
    return
  end
end