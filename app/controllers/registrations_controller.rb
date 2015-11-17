class RegistrationsController < Devise::RegistrationsController

  def new
    super do
      if params[:type] == 'admin'
        resource.admin = true
      else
        resource.guest = true
      end
    end
  end

end
