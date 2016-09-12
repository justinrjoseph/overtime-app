class Post < ActiveRecord::Base
  belongs_to :user
  
  validates :date, presence: true
  validates :rationale, presence: true
end
