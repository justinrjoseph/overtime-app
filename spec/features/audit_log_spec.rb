require 'rails_helper'

describe 'AuditLog feature' do
  let(:user) { FactoryGirl.create(:admin_user) }
  
  before do
    FactoryGirl.create(:audit_log)
    login_as user, scope: :user
  end
  
  describe 'index' do
    it 'has an index page that can be reached' do
      visit audit_logs_path
      expect(page.status_code).to eq 200
    end
    
    it 'renders audit log content' do
      visit audit_logs_path
      expect(page).to have_content AuditLog.last.user.full_name
    end
    
    it 'can not be accessed by non-admins' do
      logout(:user)
      user = FactoryGirl.create(:user)
      login_as user, scope: :user
      
      visit audit_logs_path
      expect(current_path).to eq root_path
    end
  end
end