class WelcomeController < ApplicationController

  before_action :set_user_profile , only: [:public_profile]
  before_action :set_project , only: [:public_project]

  def index
    
    if signed_in?
      @birthday_users = []
      @user_profiles = []
      if UserProfile.all.present?
          @user_profiles = UserProfile.where(status: Status.where(title: "Active").first)
          if !UserProfile.last.dob.nil?
               @birthday_users = UserProfile.where("extract(month from dob) = ?", Date.today.month).order(:dob )
              # UserProfile.all.each do |user_profile|
              # end
          end
      end
      @projects = Project.all
      @events = Event.all
    else
      redirect_to new_user_session_path
    end


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
