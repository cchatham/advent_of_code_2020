def find_nums(nums, sum)
  nums.each do |n|
    paired = sum - n
    return [n, paired] if nums.include?(paired)
  end
  false
end

def find_2020(nums)
  nums.each_with_index do |n, i|
    two_thirds = 2020 - n
    result = find_nums(nums[i+1...nums.length], two_thirds)
    return n*result[0]*result[1] if result.is_a?(Array)
  end
end

expense_report = File.readlines('input.txt').map { |line| line.to_f }
puts find_2020(expense_report)