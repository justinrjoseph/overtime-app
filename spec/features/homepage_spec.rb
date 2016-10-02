require 'rails_helper'

describe 'homepage' do
  before do
    @post = FactoryGirl.create(:post)
    @user = FactoryGirl.create(:admin_user)
    
    login_as @user, scope: :user
  end
  
  it 'allows admins to approve posts' do
    visit root_path
    
    click_on "approve_#{@post.id}"
    
    @post.reload
    
    expect(@post.status).to eq 'approved'
  end
end