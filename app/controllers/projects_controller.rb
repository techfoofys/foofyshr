class ProjectsController < InheritedResources::Base

  private

    def project_params
      params.require(:project).permit(:name, :description, :total_budget, :from, :to, :instalments)
    end
end

