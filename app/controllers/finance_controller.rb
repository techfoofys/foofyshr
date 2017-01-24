class FinanceController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_d_hr, only: [:salaries , :check_probation ,:update_probation , :get_current_salary , :pay_salary ]
    before_action :authorize_r_finance, only: [:salaries , :check_probation ,:update_probation , :get_current_salary , :pay_salary ]

    before_action :get_user, only: [:get_current_salary , :check_probation , :update_probation]

    layout false, only: [ :get_current_salary  , :check_probation , :update_probation]

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
    respond_to do |format|
      if @user.user_profile.update(probation: params[:probation])
        format.js{render :js => "get_salary_for_current_month(#{@user.id});"}
      else
        # format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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

  def get_user
    @user = User.find(params[:user_id])
  end
end
