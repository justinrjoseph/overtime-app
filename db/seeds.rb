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
  Post.create!(date: Date.today, rationale: "Quas posuere, pulvinar ducimus? Itaque eleifend saepe dolor? Ullam, hendrerit. Pellentesque lorem, aute ad? Magnis congue pariatur phasellus corporis reprehenderit, gravida sunt harum dictum, quas impedit natus neque risus expedita! Rem sed cubilia eros. Elit orci cras itaque quas class.", user: @user, overtime_request: 2.5)
end

puts "100 posts created."

AuditLog.create!(user: @user, status: 0, start_date: ( Date.today - 6.days ))
AuditLog.create!(user: @user, status: 0, start_date: ( Date.today - 13.days ))
AuditLog.create!(user: @user, status: 0, start_date: ( Date.today - 20.days ))

puts "3 audit logs created."