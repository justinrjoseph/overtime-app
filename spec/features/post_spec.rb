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
end