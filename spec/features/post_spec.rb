require 'rails_helper'

describe 'navigation' do
  before do
    @user = User.create(email: 'test@example.com', password: 'asdf1234', password_confirmation: 'asdf1234', first_name: 'John', last_name: 'Doe')
    login_as(@user, scope: :user)
  end
  
  describe 'index' do
    before do
      Post.create(date: Date.today, rationale: 'Post 1.')
      Post.create(date: Date.today, rationale: 'Post 2.')
      
      visit posts_path
    end
    
    it 'can be reached successfully' do
      expect(page.status_code).to eq 200
    end
    
    it 'has a title of Posts' do
      expect(page).to have_content 'Posts'
    end
    
    it 'has a list of Posts' do
      expect(page).to have_content(/Post 1|Post 2/)
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
      
      expect(page).to have_content 'Post created successfully.'
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
      
      expect(page).to have_content 'Post created successfully.'
      expect(page).to have_content Date.today.strftime('%m/%d/%Y')
      expect(page).to have_content 'Rationale for post with user associated.'
    end
  end
end