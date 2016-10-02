module ApplicationHelper
  def active?(path)
    'active' if current_page?(path)
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
