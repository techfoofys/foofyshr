class HrController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_d_hr, only: [:invite ]
  before_action :authorize_r_hr, only: [:invite ]

  before_action :authorize_r_hr_or_finance, only: [:users , :get_user_profile  ]

  layout false, only: [ :get_user_profile  ]



  def users
    @users = User.all
  end

  def get_user_profile
    @user_profile = UserProfile.where(user_id: get_user_id).first
    respond_to do |format|
     format.html
    end
  end

  def invite
    #Send mail
     Invite.create(get_email_name)
     InviteMailer.invite(get_email_name[:email] , get_email_name[:name]).deliver_now

     head :no_content

  end

  private

  def get_user_id
     params.require(:user_id)
  end

  def get_email_name
    params.permit(:name , :email)
  end

end
