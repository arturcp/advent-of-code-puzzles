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

    original_validation = remaining_fields.length == 0 || remaining_fields == ['cid']
    return false unless original_validation

    valid_byr? && valid_iyr? && valid_eyr? && valid_hgt? && valid_hcl? && valid_ecl? && valid_pid?
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

  def valid_byr?
    attributes['byr'].length == 4 && attributes['byr'].to_i.between?(1920, 2002)
  end

  def valid_iyr?
    attributes['iyr'].length == 4 && attributes['iyr'].to_i.between?(2010, 2020)
  end

  def valid_eyr?
    attributes['eyr'].length == 4 && attributes['eyr'].to_i.between?(2020, 2030)
  end

  def valid_hgt?
    number, unit = attributes['hgt'].scan(/\d+|\D+/)
    if unit == 'cm'
      number.to_i.between?(150, 193)
    elsif unit == 'in'
      number.to_i.between?(59, 76)
    else
      false
    end
  end

  def valid_hcl?
    valid_characters = (0..9).to_a.map(&:to_s) + ('a'..'f').to_a
    characters = attributes['hcl'].slice(1, 6).chars
    attributes['hcl'][0] == '#' && characters.length == 6 && (characters - valid_characters) == []
  end

  def valid_ecl?
    ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(attributes['ecl'])
  end

  def valid_pid?
    attributes['pid'].length == 9 && attributes['pid'].chars.map(&:to_i) - (0..9).to_a == []
  end

  def valid_cid?
    true
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