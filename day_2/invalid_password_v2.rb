def validate(password, lower_bound, upper_bound, matcher)
  return unless password.is_a?(String)

  (password[lower_bound-1] == matcher) ^ (password[upper_bound-1] == matcher)
end

counter = 0
file_input = File.readlines('input.txt').each do |line|
  l = line.split(" ")
  bounds = l[0].split("-").map { |i| i.to_i }
  matcher = l[1].split(":")[0]
  counter += 1 if validate(l[2], bounds[0], bounds[1], matcher)
end
puts counter

