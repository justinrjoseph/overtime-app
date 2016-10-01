class Post < ActiveRecord::Base
  enum status: { submitted: 0, approved: 1, rejected: 2 }
  belongs_to :user
  
  validates :date, presence: true
  validates :rationale, presence: true
  validates :overtime_request, presence: true, numericality: { greater_than: 0.0 }
  
  scope :those_by, ->(user) { where(user_id: user.id) }
end
