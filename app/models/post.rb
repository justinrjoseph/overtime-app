class Post < ActiveRecord::Base
  enum status: { submitted: 0, approved: 1, rejected: 2 }
  belongs_to :user
  
  validates :date, presence: true
  validates :rationale, presence: true
  validates :overtime_request, presence: true, numericality: { greater_than: 0.0 }
  
  scope :those_by, ->(user) { where(user_id: user.id) }
  
  after_save :update_audit_log
  
  private
  
    def update_audit_log
      audit_log = AuditLog.where(user: self.user, start_date: (self.date - 7.days..self.date)).last
      audit_log.confirmed!
    end
end
