require 'set'

group_questions = Set[]
question_counts = []
File.readlines('input.txt').each do |line|
  line.strip!
  if line == ""
    question_counts << group_questions.length
    group_questions = Set[]
  else
    line.split("").each { |c| group_questions.add(c) }
  end
end
question_counts << group_questions.length #since the file does not end in a \n

puts "Sum #{question_counts.reduce(:+)}"