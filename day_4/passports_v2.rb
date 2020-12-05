def build_hash(a_string)
  sections = a_string.gsub("\n", " ").split(" ")
  p = {}
  sections.each do |s|
    parts = s.split(":")
    p[parts[0]] = parts[1]
  end
  p
end

def validate_hash(h)
  all_keys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].reduce(true) { |result, k| result && h.keys.include?(k) }
  return false unless all_keys
 
  h.keys.reduce(true) { |result, k| result && validate_pair(k, h[k]) }
end

def validate_pair(key, value)
  case key
  when "byr"
    value.to_i.between?(1920, 2002)
  when "iyr"
    value.to_i.between?(2010, 2020)
  when "eyr"
    value.to_i.between?(2020, 2030)
  when "hgt"
    d = value.slice(value.length-2..value.length-1)
    num = value.slice(0...value.length-2)
    if d == "cm"
      num.to_i.between?(150, 193)
    elsif d == "in"
      num.to_i.between?(59, 76)
    else
      false
    end
  when "hcl"
    # Check for exactly 6 chars that are alphabet or numbers.
    /^#([a-f0-9]){6}$/.match?(value)
  when "ecl"
    ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(value)
  when "pid"
    # Check for exactly 9 numbers.
    /^([0-9]){9}$/.match?(value)
  else
    # Anything other keys we don't care about the value so just return true.
    true
  end
end

passports = []
build = ""
File.readlines('input.txt').each do |line|
  line.strip!
  if line == ""
    passports << build_hash(build)
    build = ""
  else
    build += " #{line}"
  end
end
# The file ends without another \n so ensure the last build is added on.
passports << build_hash(build)

valid_counter = 0
passports.each do |p|
  v = validate_hash(p)
  valid_counter += 1 if v == true
end

puts "Valid Counter #{valid_counter}"

