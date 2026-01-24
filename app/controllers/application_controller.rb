class ApplicationController < ActionController::Base
  before_action :configure_authentication
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end

  def after_sign_up_path_for(resource)
    users_mypage_path(resource)
  end

  def after_sign_in_path_for(resource)
    users_mypage_path
  end

  def after_sign_out_path_for(resource)
    if request.referer&.include?("edit")
      new_user_registration_path
    else
      about_path
    end
  end
 
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  def action_is_public?
    controller_name == 'homes' && (action_name == 'top' || action_name == 'about')
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
