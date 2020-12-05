passports = []
build = ""
File.readlines('input.txt').each do |line|
  line.strip!
  if line == ""
    passports << build
    build = ""
  else
    build += " #{line}"
  end
end
# The file ends without another \n so ensure the last build is added on.
passports << build

def valid(a_string) 
  ["byr:", "iyr:", "eyr:", "hgt:", "hcl:", "ecl:", "pid:"].reduce(true) { |result, k| result && a_string.include?(k) }
end

valid_passport_count = 0
passports.each do |p|
  valid_passport_count += 1 if valid(p)
end

puts valid_passport_count