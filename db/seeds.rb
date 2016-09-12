100.times do |post|
  Post.create!(date: Date.today, rationale: "Rationale for post #{post + 1}.")
end

puts "100 posts have been created."