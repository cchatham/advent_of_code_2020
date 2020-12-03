def find_nums_multiply(nums)
  nums.each do |n|
    paired = 2020 - n
    return paired * n if nums.include?(paired)
  end
  false
end

expense_report = File.readlines('input.txt').map { |line| line.to_f }
puts find_nums_multiply(expense_report)