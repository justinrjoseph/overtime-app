require 'rails_helper'

describe 'navigate' do
  before do
    @admin_user = FactoryGirl.create(:admin_user)
    login_as @admin_user, scope: :user
  end
  
  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post)
      visit edit_post_path(@post)
    end
    
    it 'has a status that can be edited by an admin' do
      choose 'post_status_approved'
      
      click_on 'Save'
      
      expect(@post.reload.status).to eq 'approved'
    end
    
    it 'can not be edited by non-admins' do
      logout(:user)
      user = FactoryGirl.create(:user)
      login_as user, scope: :user
      
      visit edit_post_path(@post)
      
      expect(page).to_not have_content 'Submitted'
      expect(page).to_not have_content 'Approved'
      expect(page).to_not have_content 'Rejected'
    end
  end
end