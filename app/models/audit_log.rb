class AuditLog < ActiveRecord::Base
  enum status: { pending: 0, confirmed: 1 }
  
  belongs_to :user
  
  validates :user, presence: true
  validates :status, presence: true
  validates :start_date, presence: true
  
  after_initialize :set_defaults
  
  before_update :set_end_date, if: :confirmed?
  
  private
  
    def set_defaults
      self.start_date ||= Date.today - 6.days
    end
    
    def set_end_date
      self.end_date = Date.today
    end
end
