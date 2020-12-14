require_relative "bag_rule_map"

RULE_MAP = build_rule_map

# Leverage map to recursively find gold as a containee.
def contains_shiny_gold(bag_type)
  return true if bag_type == "shiny gold"
  return false if RULE_MAP[bag_type] == nil
  
  a = RULE_MAP[bag_type].keys.map do |k|
    result = contains_shiny_gold(k)
    result
  end
  return a.reduce(false) { |result, d| result || d }
end

counter = 0
RULE_MAP.keys.each do |k|
  next if  k == "shiny gold"

  result = contains_shiny_gold(k)
  if result == true
    counter += 1
  end
end

puts "Counter #{counter}"

