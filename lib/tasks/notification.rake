namespace :notification do
  desc "Sends SMS to employees asking them to log overtime."
  task sms: :environment do
    if Time.now.sunday?
      # Schedule to run Sunday at 5pm
      # Iterate over all employees, skipping AdminUsers
      # Send a message containing instructions and link to application
      # User.all.each do |user|
      #   SmsTool.send(number: , message:)
      # end
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
