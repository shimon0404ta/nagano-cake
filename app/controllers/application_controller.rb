class ApplicationController < ActionController::Base
  def after_sign_up_path_for(resource)
    if resource == :admin
      root_path
    else
      mypage_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      root_path
    end
  end

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name,
                                                       :last_name_kana, :first_name_kana,
                                                       :postal_code, :address, :telephone_number])
  end
end
