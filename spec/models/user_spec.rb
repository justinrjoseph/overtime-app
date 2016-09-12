require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    before do
      @user = User.create(email: 'test@example.com', password: 'asdf1234', password_confirmation: 'asdf1234', first_name: 'John', last_name: 'Doe')
    end
    
    it 'can be created' do
      expect(@user).to be_valid
    end
    
    it 'cannot be created without first_name and last_name' do
      @user.first_name = nil
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
  end
end
