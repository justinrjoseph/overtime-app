namespace :notification do
  desc "Sends SMS to employees asking them to log overtime."
  task sms: :environment do
    if Time.now.sunday?
      employees = Employee.all
      message = "Please log in to the overtime management dashboard to request overtime or confirm your hours for the prior week. https://overtime-app-justin-joseph.herokuapp.com"
      
      employees.each do |employee|
        AuditLog.create!(user: employee)
        SmsTool.send(number: employee.phone_number, message: message)
      end
    end
  end
  
  desc "Sends mail notifications to managers (admins) each day to inform of pending overtime requests"
  task manager_email: :environment do
    submitted_posts = Post.submitted
    admins = AdminUser.all
    
    unless submitted_posts.empty?
      admins.each do |admin|
        ManagerMailer.email(admin).deliver_later
      end
    end
  end
end
