class ProjectsController < InheritedResources::Base

  before_action :authenticate_user!
  
  before_action :authorize_d_hr, only: [:index , :show ,:new , :edit , :create , :update , :destroy]

  private

    def project_params
      params.require(:project).permit(:name, :description, :total_budget, :from, :to, :instalments)
    end
end
