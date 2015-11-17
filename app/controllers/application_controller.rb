class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Add name to devise strong parameters
    sign_up_params = [:name, :last_name, :birthday, :admin, :guest,
                      avatar_attributes: [
                        :image, :title, :id, :remove_image ],
                      passport_attributes: [
                        :image, :title, :id, :remove_image ]]
    devise_parameter_sanitizer.for(:sign_up).concat sign_up_params
  end

end
