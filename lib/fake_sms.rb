module FakeSms
  # structure that mimics a database
  Message = Struct.new(:number, :message)
  @messages = []
  
  def self.send(number:, message:)
    @messages << Message.new(number, message)
  end
  
  def self.messages
    @messages
  end
end