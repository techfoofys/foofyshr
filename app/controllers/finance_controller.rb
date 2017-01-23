class FinanceController < ApplicationController
  before_action :get_user_id, only: [:get_current_salary , :check_probation]
    layout false, only: [ :get_current_salary  , :check_probation ]

  def salaries
    @salaries = Salary.all
  end

  def check_probation

    @transaction = SalaryTransaction.where(user_id: @user)
    if @transaction.present?
      if  @user.salary.prov_period <=  @transaction.count
        respond_to do |format|
          format.html
        end
      else
        respond_to do |format|
         format.json { render json: 'Not Yet Completed' }
        end
      end
    else
      respond_to do |format|
       format.json { render json: 'Not Yet Completed' }
      end
    end



  end

  def update_probation
    byebug
  end

  def get_current_salary
    @sal_trans = SalaryTransaction.new(user: @user)
    transaction = SalaryTransaction.where(user_id: @user)
    if transaction.present?
      if @user.user_profile.probation
        @sal_trans.amount = @user.salary.initial_amount_per_month
      else
        @sal_trans.amount = @user.salary.amount / 12
      end
    else
      if @user.user_profile.probation
        @sal_trans.amount = @user.salary.initial_amount_per_month
      else
        @sal_trans.amount = @user.salary.amount / 12
      end
    end

  end


  def pay_salary
    #code
  end

  private

  def get_user_id
    @user = User.find(params[:user_id])
  end
end
