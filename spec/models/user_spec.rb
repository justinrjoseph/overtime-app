require 'rails_helper'

RSpec.describe User, type: :model do
  before do
      @user = FactoryGirl.create(:user)
    end
    
  describe 'creation' do
    it 'can be created' do
      expect(@user).to be_valid
    end
  end
  
  describe 'validations' do
    it 'cannot be created without first_name' do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end
    
    it 'cannot be created without last_name' do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
    
    it 'cannot be created without phone_number' do
      @user.phone_number = nil
      expect(@user).to_not be_valid
    end
    
    it 'requires phone_number to contain only integers' do
      @user.phone_number = 'mygreatstr'
      expect(@user).to_not be_valid
    end
    
    it 'requires phone_number to be no more than ten characters' do
      @user.phone_number = '55555555555'
      expect(@user).to_not be_valid
    end
  end
  
  describe 'custom name methods' do
    it 'has a full_name method that concatenates first_name and last_name' do
      expect(@user.full_name).to eq 'DOE, JOHN'
    end
  end
end
