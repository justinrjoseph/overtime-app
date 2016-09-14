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
  
  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post)
    end
    
    it 'can be reached by clicking Edit on index page' do
      visit posts_path
      
      click_link "edit_#{@post.id}"
      expect(page.status_code).to eq 200
    end
    
    it 'can be edited' do
      visit edit_post_path(@post)
      
      fill_in 'post[rationale]', with: 'Edited rationale.'
      
      click_on 'Save'
      
      @post.reload
      
      expect(@post.date).to eq Date.today
      expect(@post.rationale).to eq 'Edited rationale.'
      
      expect(page).to have_content 'Post updated successfully.'
      expect(page).to have_content Date.today.strftime('%m/%d/%Y')
      expect(page).to have_content 'Edited rationale.'
    end
  end
  
  describe 'delete' do
    it 'can be deleted' do
      post = FactoryGirl.create(:post)
      visit posts_path
      
      click_link "delete_#{post.id}"
      expect(page.status_code).to eq 200
      
      expect(page).to have_content "'#{post.rationale}' was deleted."
      expect(page).not_to have_content post.id
    end
  end
end