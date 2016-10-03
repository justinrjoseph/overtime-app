require 'rails_helper'

describe 'navigation' do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) do
    Post.create(date: Date.today, rationale: 'Rationale.', user: user, overtime_request: 3.5)
  end
  
  before do
    login_as(user, scope: :user)
  end
  
  describe 'index' do
    before do
      FactoryGirl.create(:post, user: user)
      FactoryGirl.create(:post_2, user: user)
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
    
    it 'is scoped so only creators can see their posts' do
      other_user = User.create(
        first_name: 'Test',
        last_name: 'User',
        email: 'test_user@example.com',
        password: 'asdf1234',
        password_confirmation: 'asdf1234',
        phone_number: '5555555555'
      )
      
      Post.create(date: Date.today, rationale: 'should not be seen', user: other_user, overtime_request: 3.5)
      
      visit posts_path
      
      expect(page).to_not have_content 'should not be seen'
    end
  end
  
  describe 'new' do
    it 'has a link on the home page' do
      visit root_path
      click_link 'Request Overtime'
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
      fill_in 'post[overtime_request]', with: 1.5
      
      expect { click_on 'Save' }.to change(Post, :count).by(1)
    end
    
    it 'will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Rationale for post with user associated.'
      fill_in 'post[overtime_request]', with: 4.5
      
      click_on 'Save'
      
      post = Post.last
      
      expect(post.user).to eq user
      expect(user.posts.last.date).to eq Date.today
      expect(user.posts.last.rationale).to eq 'Rationale for post with user associated.'
      
      expect(page).to have_content Date.today.strftime('%m/%d/%Y')
      expect(page).to have_content 'Rationale for post with user associated.'
    end
  end
  
  describe 'edit' do
    it 'can be edited' do
      visit edit_post_path(post)
      
      fill_in 'post[rationale]', with: 'Edited rationale.'
      
      click_on 'Save'
      
      post.reload
      
      expect(post.date).to eq Date.today
      expect(post.rationale).to eq 'Edited rationale.'
      
      expect(page).to have_content Date.today.strftime('%m/%d/%Y')
      expect(page).to have_content 'Edited rationale.'
    end
    
    it 'can not be edited by a non-authorized user' do
      logout(:user)
      
      non_authorized_user = FactoryGirl.create(:non_authorized_user)
      login_as non_authorized_user, scope: :user
      
      visit edit_post_path(post)
      
      expect(current_path).to eq root_path
    end
  end
  
  describe 'delete' do
    it 'can be deleted' do
      logout(:user)
      
      user = FactoryGirl.create(:user)
      login_as user, scope: :user
      
      post_to_delete = Post.create(date: Date.today, rationale: 'To be deleted.', user: user, overtime_request: 3.5)
      
      visit posts_path
      
      click_link "delete_#{post_to_delete.id}"
      
      expect(page.status_code).to eq 200
      expect(page).not_to have_content post_to_delete.id
    end
  end
end