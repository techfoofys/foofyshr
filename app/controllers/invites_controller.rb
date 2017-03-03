class InvitesController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :authorize_d_hr
  before_action :authorize_r_hr 

  private

    def invite_params
      params.require(:invite).permit(:name, :email)
    end
end
