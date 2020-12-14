def strip_out_bags(s)
  #probably should return it instead of modifying the instance here.
  s.slice!(/bags?\.?,?/)
  s.strip!
end

def build_rule_map
  # Build out the map
  rule_map = {}
  File.readlines('input.txt').each do |line|
    line.strip!
    split_it = line.split("contain")
    # split_it[0] is container. split_it[1] is valid containees
    key = strip_out_bags(split_it[0])
    split_it[1].strip!
    if split_it[1].include?("no other bags.")
      rule_map[key] = nil
    else
      val = {}
      # splits out each valid type containee.
      a = split_it[1].split(",")
      a.each do |i|
        strip_out_bags(i)
        b = i.split(" ", 2)
        num = b[0]
        qual = b[1]
        val[qual] = num
      end
      rule_map[key] = val
    end
  end
  rule_map
end