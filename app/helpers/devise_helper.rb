module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg)
    }.join
    render partial: 'layouts/message',
           locals: { type: 'error', message: messages.html_safe }
  end
end