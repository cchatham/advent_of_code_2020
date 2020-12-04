FILE_INPUT = File.readlines('input.txt').map { |l| l.strip! }
NUM_LINES = FILE_INPUT.length

def slope(right, down) 
  line = 0
  line_item = 0
  trees = 0
  while (line < NUM_LINES) do
    trees += 1 if FILE_INPUT[line][line_item] == "#"
    # Move right
    right_item = line_item + right
    if right_item < FILE_INPUT[line].length
      line_item = right_item
    else
      # Restart in the same line to "repeat" the pattern.
      line_item = right - (FILE_INPUT[line].length - line_item)
    end
    line += down # Move down
  end
  trees
end


puts "Starting problem answer #{slope(3, 1)}"
puts "--- Second followup problem ---"
one_one = slope(1, 1)
three_one = slope(3, 1)
five_one = slope(5, 1)
seven_one = slope(7, 1)
one_two = slope(1, 2)
puts "Right 1, down 1. #{one_one}"
puts "Right 3, down 1. #{three_one}"
puts "Right 5, down 1. #{five_one}"
puts "Right 7, down 1. #{seven_one}"
puts "Right 1, down 2. #{one_two}"
puts "Multiply Total: #{one_one * three_one * five_one * seven_one * one_two}"
