class WelcomeController < ApplicationController
  def index
    @user_profiles = UserProfile.where(status: Status.where(title: "Active").first)
    @birthday_users = UserProfile.where("cast(strftime('%m', dob) as int) = ?", Date.today.month).order(:dob )
    @projects = Project.all
  end

  def public_profile
    #code
  end
end
