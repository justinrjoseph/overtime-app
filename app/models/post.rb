class Post < ActiveRecord::Base
  enum status: { submitted: 0, approved: 1, rejected: 2 }
  belongs_to :user
  
  validates :date, presence: true
  validates :rationale, presence: true
end
