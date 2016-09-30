module PostsHelper
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
      else
        return content_tag(:span, status, class: 'label label-danger')
      end
    end
end
