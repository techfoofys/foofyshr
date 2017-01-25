class SalaryTransactionsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :authorize_d_hr, only: [ :create ]
  before_action :authorize_r_finance , only: [:index , :edit , :show, :update , :destroy , :new] 

  def create
    @salary_trans = SalaryTransaction.new(salary_transaction_params)

    respond_to do |format|
      if @salary_trans.save
        format.html { redirect_to salaries_finance_index_path, notice: 'Salary Paid  successfully .' }
        format.json { render :show, status: :created, location: @salary }
      else
        format.html { render :new }
        format.json { render json: @salary_trans.errors, status: :unprocessable_entity }
      end
    end

  end

  private

    def salary_transaction_params
      params.require(:salary_transaction).permit(:user_id, :month, :amount)
    end
end
