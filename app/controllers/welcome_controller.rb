class WelcomeController < ApplicationController

  before_action :set_user_profile , only: [:public_profile]
  before_action :set_project , only: [:public_project]

  def index
    
    @user_profiles = UserProfile.where(status: Status.where(title: "Active").first)
    @birthday_users = []
    if UserProfile.all.present?
        @birthday_users = UserProfile.where("cast(strftime('%m', dob) as int) = ?", Date.today.month).order(:dob )
    end

    @projects = Project.all
    @events = Event.all
  end

  def public_profile

  end

  def public_project
    #code
  end

  private

  def set_user_profile
    @user_profile = UserProfile.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
