class InstalmentsController < InheritedResources::Base

  before_action :authenticate_user!
  before_action :authorize_d_hr
  before_action :authorize_r_finance

  private

    def instalment_params
      params.require(:instalment).permit(:project_id, :instalment_date, :amount, :instalment_no)
    end
end
