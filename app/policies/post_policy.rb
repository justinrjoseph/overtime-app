class PostPolicy < ApplicationPolicy
  def update?
    return true if approved? && admin?
    
    unless approved?
      return true if permitted_user?
    end
  end
  
  private
  
    def permitted_user?
      record.user_id == user.id || admin?
    end
    
    def admin?
      admin_types.include?(user.type)
    end
    
    def approved?
      record.approved?
    end
end