class Post < ActiveRecord::Base
  validates :date, presence: true
  validates :rationale, presence: true
end
