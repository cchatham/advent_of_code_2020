require "pry"
require_relative "bag_rule_map"

RULE_MAP = build_rule_map

def count_bags(bag_type)
  return 1 if RULE_MAP[bag_type] == nil

  bag_sum = 1 # include the container bag in the count.
  RULE_MAP[bag_type].each_pair do |k, v|
    result = count_bags(k)
    bag_sum += result * v.to_i
  end
  bag_sum
end

# Subtract one because are we including containers in the function call 
# but dont include the original shiny gold in the count.
puts "Sum #{count_bags("shiny gold") - 1}"