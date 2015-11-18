class RegistrationsController < Devise::RegistrationsController

  def new
    super do
      resource.shop_owner = resource.guest = resource.admin = false
      if params[:type] == 'admin'
        resource.admin = true
      elsif params[:type] == 'shop_owner'
        resource.shop_owner = true
      else
        resource.guest = true
      end
    end
  end



end
