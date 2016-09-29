require 'rails_helper'

describe 'navigation' do
  before do
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
  end
  
  describe 'index' do
    before do
      FactoryGirl.create(:post)
      FactoryGirl.create(:post_2)
      visit posts_path
    end
    
    it 'can be reached successfully' do
      expect(page.status_code).to eq 200
    end
    
    it 'has a title of Posts' do
      expect(page).to have_content 'Posts'
    end
    
    it 'has a list of Posts' do
      expect(page).to have_content(/Some rationale.|Different rationale./)
    end
  end
  
  describe 'new' do
    it 'has a link on the home page' do
      visit root_path
      click_link 'New Time Entry'
      expect(page.status_code).to eq 200
    end
  end
  
  describe 'creation' do
    before do
      visit new_post_path
    end
    
    it 'has a new form that can be reached' do
      expect(page.status_code).to eq 200
    end
    
    it 'can be created using new form' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some rationale.'
      
      click_on 'Save'
      
      expect(page).to have_content Date.today.strftime('%m/%d/%Y')
      expect(page).to have_content 'Some rationale.'
    end
    
    it 'will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Rationale for post with user associated.'
      
      click_on 'Save'
      
      post = Post.last
      
      expect(post.user).to eq @user
      expect(@user.posts.last.date).to eq Date.today
      expect(@user.posts.last.rationale).to eq 'Rationale for post with user associated.'
      
      expect(page).to have_content Date.today.strftime('%m/%d/%Y')
      expect(page).to have_content 'Rationale for post with user associated.'
    end
  end
  
  describe 'edit' do
    before do
      edit_user = User.create(first_name: 'Edit', last_name: 'User', email: 'edit_user@example.com', password: 'asdf1234', password_confirmation: 'asdf1234')
      login_as(edit_user, scope: :user)
      @edit_post = Post.create(date: Date.today, rationale: 'asdf', user: edit_user)
    end
    
    it 'can be edited' do
      visit edit_post_path(@edit_post)
      
      fill_in 'post[rationale]', with: 'Edited rationale.'
      
      click_on 'Save'
      
      @edit_post.reload
      
      expect(@edit_post.date).to eq Date.today
      expect(@edit_post.rationale).to eq 'Edited rationale.'
      
      expect(page).to have_content Date.today.strftime('%m/%d/%Y')
      expect(page).to have_content 'Edited rationale.'
    end
    
    it 'can not be edited by a non-authorized user' do
      logout(:user)
      
      non_authorized_user = FactoryGirl.create(:non_authorized_user)
      login_as non_authorized_user, scope: :user
      
      visit edit_post_path(@edit_post)
      
      expect(current_path).to eq root_path
    end
  end
  
  describe 'delete' do
    it 'can be deleted' do
      post = FactoryGirl.create(:post)
      visit posts_path
      
      click_link "delete_#{post.id}"
      expect(page.status_code).to eq 200
      
      expect(page).not_to have_content post.id
    end
  end
end