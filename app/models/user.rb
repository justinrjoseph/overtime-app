class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :posts
  has_many :audit_logs
  
  REGEX_PHONE_NUMBER = /\A[0-9]*\Z/
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true,
                           format: { with: REGEX_PHONE_NUMBER },
                           length: { is: 10 }
  
  def full_name
    "#{last_name.upcase}, #{first_name.upcase}"
  end
end
