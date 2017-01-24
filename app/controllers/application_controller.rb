class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user

  protected

  def configure_permitted_parameters
    added_attrs = [:name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def authorize_d_hr
    redirect_to root_path unless current_user.user_profile.designation.title == "HR"
  end
  def authorize_r_hr
    redirect_to root_path unless current_user.user_profile.role.title == "HR"
  end
  def authorize_r_finance
    redirect_to root_path unless current_user.user_profile.role.title == "Finance"
  end
  def authorize_r_hr_or_finance
    redirect_to root_path unless current_user.user_profile.role.title == "HR" || current_user.user_profile.role.title == "Finance"
  end

  def check_user
    if  signed_in?
      if !UserProfile.where(user_id: current_user.id).present?
        user_profile = UserProfile.new(user: current_user)
        user_profile.role = Role.where(title: "ROR Develoepr").first
        user_profile.designation = Designation.where(title: "Developer").first
        user_profile.address = "Need to be filled"
        user_profile.per_address = "Need to be filled"
        user_profile.status = Status.where(title: "Deactive").first
        user_profile.save!
      end
    end
  end

end
