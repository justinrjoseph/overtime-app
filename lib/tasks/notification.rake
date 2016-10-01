namespace :notification do
  desc "Sends SMS to employees asking them to log overtime."
  task sms: :environment do
    # Schedule to run Sunday at 5pm
    # Iterate over all employees, skipping AdminUsers
    # Send a message containing instructions and link to application
    # User.all.each do |user|
    #   SmsTool.send(number: , message:)
    # end
  end

end
