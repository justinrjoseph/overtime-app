require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryGirl.create(:post)
  end
  
  describe 'creation' do
    it 'can be created' do
      expect(@post).to be_valid
    end
    
    it 'cannot be created without a date and rationale' do
      @post.date = nil
      @post.rationale = nil
    end
  end
end
