require 'rails_helper'

describe 'homepage' do
  it 'allows admins to approve posts' do
    post = FactoryGirl.create(:post)
    user = FactoryGirl.create(:admin_user)
    
    login_as user, scope: :user
    
    visit root_path
    
    click_on "approve-#{post.id}"
    
    post.reload
    
    expect(post.status).to eq 'approved'
  end
  
  it 'allows employees to change the status of audit logs' do
    user = FactoryGirl.create(:user)
    audit_log = FactoryGirl.create(:audit_log, user: user)
    
    login_as user, scope: :user
    
    visit root_path
    
    click_on "confirm-#{audit_log.id}"
    
    audit_log.reload
    
    expect(audit_log.status).to eq 'confirmed'
  end
end