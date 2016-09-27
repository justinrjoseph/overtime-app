@user = User.create(email: 'test@example.com', password: 'asdf1234', password_confirmation: 'asdf1234', first_name: 'John', last_name: 'Doe')
User.create(email: 'justin@example.com', password: 'asdf1234', password_confirmation: 'asdf1234', first_name: 'Justin', last_name: 'Joseph')
AdminUser.create(email: 'admin@example.com', password: 'asdf1234', password_confirmation: 'asdf1234', first_name: 'Admin', last_name: 'User')

puts "Two users, and one AdminUser created."

100.times do |post|
  Post.create!(date: Date.today, rationale: "Rationale for post #{post + 1}.", user: @user)
end

puts "100 posts have been created."