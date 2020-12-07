TreeNode = Struct.new(:lower, :upper, :next_lower, :next_upper)

# Building the tree with indicies so add 1 to the maxes for proper math.
# eg row 0-63 is 64 rows.
def build_tree_node(l, u) 
  return TreeNode.new(l, u, nil, nil) if l == u
  
  half_it = ((u - l) + 1) / 2
  if half_it <= 1
    TreeNode.new(l,
      u,
      build_tree_node(l, l),
      build_tree_node(u, u)
    )
  else
    TreeNode.new(
      l,
      u,
      build_tree_node(l, l + half_it-1),
      build_tree_node(u-half_it+1, u)
    )
  end
end

def walk_tree(directions, tree, low_indicator, up_indicator)
  find_it = tree
  directions.each do |d|
    if d == low_indicator
      find_it = find_it.next_lower
    elsif d == up_indicator
      find_it = find_it.next_upper
    else
      puts "ERROR: Invalid pattern"
    end
  end
  if find_it.next_lower != nil || find_it.next_upper != nil
    puts "ERROR: Did not find end node."
  end
  find_it.lower # lower and upper are the same value for end nodes.
end

# empty_seats = []
# def find_missing(tree)
#   if tree.next_lower == nil
#     empty_seats << tree unless tree.taken
#     return
#   end

#   find_missing(tree.next_lower)
#   find_missing(tree.next_upper)
# end

def seat_id(row, col)
  row * 8 + col
end

row_tree = build_tree_node(0, 127)
col_tree = build_tree_node(0, 7)

highest = 0
seat_map = Hash[(0...1024).each_with_object(false).to_a]
File.readlines('input.txt').each do |line|
  line.strip!
  # First 7 are guaranteed to be row directions. Last 3 are column directions.
  rows = line.slice(0...7).split("")
  cols = line.slice(7...line.length).split("")
  r = walk_tree(rows, row_tree, "F", "B")
  c = walk_tree(cols, col_tree, "L", "R")
  id = seat_id(r, c)
  seat_map[id] = true
  highest = id if id >= highest
end

puts "Highest Seat Id: #{highest}"

middle = 1024 / 2
found = -1

def detect(middle, seat_map)
  result = seat_map[middle] == false && seat_map[middle - 1] == true && seat_map[middle + 1] == true
  found = middle if result
  result
end

while(found == -1 && middle >= 0) do
  detect(middle, seat_map)
  middle -= 1
end

# If we didn't find it in the beginning half, try the later half.
middle = 1024 / 2
while(found == -1 && middle < 1024) do
  detect(middle, seatmap)
  middle += 1
end

puts "Found #{found}"