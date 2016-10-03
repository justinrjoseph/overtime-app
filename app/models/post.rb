class Post < ActiveRecord::Base
  enum status: { submitted: 0, approved: 1, rejected: 2 }
  belongs_to :user
  
  validates :date, presence: true
  validates :rationale, presence: true
  validates :overtime_request, presence: true, numericality: { greater_than: 0.0 }
  
  scope :those_by, ->(user) { where(user_id: user.id) }
  
  after_save :confirm_audit_log, if: :submitted?
  after_save :unconfirm_audit_log, if: :rejected?
  
  private
  
    def confirm_audit_log
      audit_log = find_audit_log
      audit_log.confirmed! if audit_log
    end
    
    def unconfirm_audit_log
      audit_log = find_audit_log
      audit_log.pending! if audit_log
    end
    
    def find_audit_log
      return AuditLog.where(user: self.user, start_date: (self.date - 7.days..self.date)).last
    end
end
