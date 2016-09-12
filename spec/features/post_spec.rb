require 'rails_helper'

describe 'navigation' do
  describe 'index' do
    before do
      visit posts_path
    end
    
    it 'can be reached successfully' do
      expect(page.status_code).to eq 200
    end
    
    it 'has a title of Posts' do
      expect(page).to have_content 'Posts'
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
  end
end