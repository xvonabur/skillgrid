module ApplicationHelper
  # Styling flash messages for bootstrap
  def flash_class(level)
    level = level.to_s
    case level
      when 'notice' then 'alert alert-info'
      when 'success' then 'alert alert-success'
      when 'error' then 'alert alert-error'
      when 'alert' then 'alert alert-error'
      when 'danger' then 'alert alert-danger'
    end
  end

  def user_role(user)
    if user.admin?
      I18n.t('user.roles.admin')
    elsif user.shop_owner?
      I18n.t('user.roles.shop_owner')
    else
      I18n.t('user.roles.guest')
    end
  end
end
