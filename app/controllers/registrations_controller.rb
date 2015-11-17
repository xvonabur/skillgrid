class RegistrationsController < Devise::RegistrationsController

  def new
    super do
      if params[:type] == 'admin'
        resource.admin = true
      end
    end
  end

end
