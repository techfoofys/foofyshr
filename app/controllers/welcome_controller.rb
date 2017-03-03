class WelcomeController < ApplicationController

  before_action :set_user_profile , only: [:public_profile]
  before_action :set_project , only: [:public_project]

  def index


    @birthday_users = []
    @user_profiles = []
    if UserProfile.all.present?
        @user_profiles = UserProfile.where(status: Status.where(title: "Active").first)
        if !UserProfile.last.dob.nil?
            @birthday_users = UserProfile.where("cast(strftime('%m', dob) as int) = ?", Date.today.month).order(:dob )
        end

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
