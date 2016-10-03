module ApplicationHelper
  def admin_types
    ['AdminUser']  
  end
  
  def active?(path)
    'active' if current_page?(path)
  end
  
  def employee?
    current_user.type.eql? 'Employee'
  end
  
  def admin?
    admin_types.include?(current_user.type)
  end
  
  def status_label(status)
    status_span_generator(status)
  end
  
  private
  
    def status_span_generator(status)
      case status
      when 'SUBMITTED'
        return content_tag(:span, status, class: 'label label-primary')
      when 'APPROVED'
        return content_tag(:span, status, class: 'label label-success')
      when 'REJECTED'
        return content_tag(:span, status, class: 'label label-danger')
      when 'PENDING'
        return content_tag(:span, status, class: 'label label-warning')
      when 'CONFIRMED'
        return content_tag(:span, status, class: 'label label-success')
      end
    end
end
