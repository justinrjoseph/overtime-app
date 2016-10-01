@user = User.create(
  email: 'test@example.com',
  password: 'asdf1234',
  password_confirmation: 'asdf1234',
  first_name: 'John',
  last_name: 'Doe',
  phone_number: '4123243220'
)

User.create(
  email: 'justin@example.com',
  password: 'asdf1234',
  password_confirmation: 'asdf1234',
  first_name: 'Justin',
  last_name: 'Joseph',
  phone_number: '4123243220'
)

AdminUser.create(
  email: 'admin@example.com',
  password: 'asdf1234',
  password_confirmation:'asdf1234',
  first_name: 'Admin',
  last_name: 'User',
  phone_number: '4123243220'
)

puts "Two users, and one AdminUser created."

100.times do |post|
  Post.create!(date: Date.today, rationale: "Rationale for post #{post + 1}.", user: @user, overtime_request: 2.5)
end

100.times do |audit_log|
  AuditLog.create!(user: User.last, status: 0, start_date: ( Date.today - 6.days ))
end

puts "100 posts and audit logs have been created."