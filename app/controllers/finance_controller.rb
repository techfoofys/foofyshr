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
    # transaction = SalaryTransaction.where(user_id: @user)

    if UserProfile.where(user_id: @user).first.doj < Time.now - 1.month
      if @user.user_profile.probation
        @sal_trans.amount = (@user.salary.initial_amount_per_month).round
      else
        @sal_trans.amount = (@user.salary.amount / 12).round
      end
    else
      #First Salary
      salary_month = Time.now - 1.month
      days = Time.days_in_month(salary_month.month, salary_month.year)

      user_date_oj = UserProfile.where(user_id: @user).first.doj.day
      working_days = days - user_date_oj

      if @user.user_profile.probation
        @sal_trans.amount = (((@user.salary.initial_amount_per_month)/days) * working_days ).round
      else
        @sal_trans.amount = (((@user.salary.amount / 12)/days) * working_days ).round
      end
    end

    #Calculate Partial Salary
    sal_month = Time.now - 1.month
    transactionof_sal_month = SalaryTransaction.where( "cast(strftime('%m', month) as int) = ?", sal_month.month  )
    user_transactions_of_sal_month = transactionof_sal_month.where(user_id: @user)
    total_transaction_for_sal_month = user_transactions_of_sal_month.sum(:amount)

    #Removing Already Paid Salary for the month
    @sal_trans.amount =   @sal_trans.amount - total_transaction_for_sal_month

  end


  def pay_salary
    #code
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end
end
