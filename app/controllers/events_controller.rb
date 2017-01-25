class EventsController < InheritedResources::Base

  before_action :authenticate_user!

  before_action :authorize_d_hr, only: [:index , :show ,:new , :edit , :create , :update , :destroy]
  before_action :authorize_r_hr, only: [:index , :show ,:new , :edit , :create , :update , :destroy]

  private

    def event_params
      params.require(:event).permit(:name, :description, :event_date, :status_id)
    end
end
