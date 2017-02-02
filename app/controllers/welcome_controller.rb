class WelcomeController < ApplicationController

  before_action :set_user_profile , only: [:public_profile]

  def index
    @user_profiles = UserProfile.where(status: Status.where(title: "Active").first)
    @birthday_users = UserProfile.where("cast(strftime('%m', dob) as int) = ?", Date.today.month).order(:dob )
    @projects = Project.all
    @events = Event.all
  end

  def public_profile
    
  end

  private

  def set_user_profile
    @user_profile = UserProfile.find(params[:id])
  end
end
