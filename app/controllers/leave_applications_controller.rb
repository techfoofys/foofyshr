class LeaveApplicationsController < InheritedResources::Base

  private

    def leave_application_params
      params.require(:leave_application).permit(:from, :to, :reason, :status, :user_id)
    end
end

