member_count = 0
group_questions = {}
question_counts = []
File.readlines('input.txt').each do |line|
  line.strip!
  if line == ""
    everyone_answered = group_questions.select { |question, answer_count| answer_count == member_count}
    question_counts << everyone_answered.keys.length
    member_count = 0
    group_questions = {}
  else
    member_count += 1
    line.split("").each do |c| 
      if group_questions[c] == nil
        group_questions[c] = 1
      else
        group_questions[c] += 1
      end
    end
  end
end
question_counts << group_questions.select { |question, answer_count| answer_count == member_count}.keys.length

puts "Sum #{question_counts.reduce(:+)}"