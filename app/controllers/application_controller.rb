class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?

  # rescue_from Pundit::NotAuthorizedError do |exception|
  #   redirect_to root_path, alert: exception.message
  # end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def update_allowed_parameters
    permissions = proc do |user|
      user.permit(:email, :username,
                  :name,  :password,
                  :avatar, :password_confirmation,
                  :current_password, :provider, :uid)
    end

    devise_parameter_sanitizer.permit(:sign_up, &permissions)
    devise_parameter_sanitizer.permit(:account_update, &permissions)
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
