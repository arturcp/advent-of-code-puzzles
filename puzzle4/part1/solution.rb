require_relative '../input.rb'

class Passport
  attr_reader :data

  REQUIRED_FIELDS = [
    'byr',
    'iyr',
    'eyr',
    'hgt',
    'hcl',
    'ecl',
    'pid',
    'cid'
  ]

  def initialize(data)
    @data = data.join(' ')
  end

  def valid?
    remaining_fields = REQUIRED_FIELDS - attributes.keys

    remaining_fields.length == 0 || remaining_fields == ['cid']
  end

  private

  def attributes
    @attributes ||= begin
      key_value_attributes = data.split(' ')
      key_value_attributes.each_with_object({}) do |key_value_attribute, attributes|
        key, value = key_value_attribute.split(':')
        attributes[key] = value
      end
    end
  end
end

current_passport_data = []
valid_passports = 0
(INPUT + ['']).each do |input_line|
  if input_line.empty?
    passport = Passport.new(current_passport_data)
    valid_passports += 1 if passport.valid?
    current_passport_data = []
  else
    current_passport_data << input_line
  end
end

puts valid_passports