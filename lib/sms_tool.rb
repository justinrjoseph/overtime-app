module SmsTool
  def self.send(number:, message:)
    puts 'Sending SMS...'
    puts "#{message} to #{number}"
  end
end