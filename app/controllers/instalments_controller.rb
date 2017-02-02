class InstalmentsController < InheritedResources::Base

  before_action :authenticate_user!
  before_action :authorize_d_hr
  before_action :authorize_r_finance

  layout false, only: [ :get_instalments ]

  def get_instalments

    @instalments = Instalment.where(project_id: get_project_params[:project_id]).order(instalment_no:  :asc)

    if   !@instalments.present?
      project = Project.find(get_project_params[:project_id])
      no_instalments = project.no_instalments
      while no_instalments > 0 do
        Instalment.create(project_id: project.id , instalment_no: no_instalments )
        no_instalments = no_instalments - 1
      end
      @instalments = Instalment.where(project_id: get_project_params[:project_id]).order(instalment_no:  :asc)

    end

    respond_to do |format|
      format.html
    end

  end

  def update

    @instalment = Instalment.find(params[:id])
    if @instalment.update(instalment_params)
      respond_to do |format|
            format.js 
      end
    end

  end


  private

  def get_project_params
     params.permit(:project_id)
  end

    def instalment_params
      params.require(:instalment).permit(:project_id, :instalment_date, :amount, :instalment_no)
    end
end
