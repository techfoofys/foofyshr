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
    doj = @user.user_profile.doj
    probation_period = @user.salary.prov_period
    probation_end_date = doj + probation_period.month
    current_month_for_salary = Time.now.beginning_of_month

    if current_month_for_salary < probation_end_date
      respond_to do |format|
       format.json { render json: 'Not Yet Completed' }
      end
    else
      respond_to do |format|
        format.html
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
    
    salary_month = Time.now - 1.month
    days = Time.days_in_month(salary_month.month, salary_month.year)

    doj = @user.user_profile.doj

    if  doj < Time.now - 1.month
      working_days = days
    else
      #First Salary
       working_days = days - doj.day
    end

    sal_per_month = 0

    if !@user.user_profile.probation.nil?

      if  @user.user_profile.probation
        sal = @user.salary.initial_amount_per_month
        sal_per_month = sal

        # salary_month = Time.now - 1.month
        # days = Time.days_in_month(salary_month.month, salary_month.year)
        sal_per_day = sal_per_month / days

        #Final Slalary for Probation Period
        salary_for_month =   (working_days * sal_per_day).round

      else
        # Final Salary for Reqular user
        sal = @user.salary.amount
        sal_per_month = sal / 12
        salary_month = Time.now - 1.month
        days = Time.days_in_month(salary_month.month, salary_month.year)
        sal_per_day = sal_per_month / days

        probation_period = @user.salary.prov_period
        probation_end_date = doj + probation_period.month
        probation_end_date = probation_end_date - 1.day
        start_month = salary_month.beginning_of_month
        end_month = salary_month.end_of_month

        if probation_end_date >= start_month && probation_end_date <= end_month
          ## Employee probation is going to over this month
          probation_days = (probation_end_date.to_date - start_month.to_date).to_i + 1

          #Probation Salary
          prob_sal_per_day = @user.salary.initial_amount_per_month / days

          probation_sal = prob_sal_per_day * probation_days

          regular_days = (end_month.to_date - probation_end_date.to_date )
          reg_sal_per_day = sal_per_day
          reg_sal = reg_sal_per_day *  regular_days

          #Final Salary for a person some for probation and remaing for regular
          salary_for_month = (probation_sal +  reg_sal).round
        else
          salary_for_month =   (working_days * sal_per_day).round
        end

      end

    end

   #Calculate Partial Salary
   sal_month = Time.now - 1.month
   transactionof_sal_month = SalaryTransaction.where( "extract(month from month)  = ?", sal_month.month  )
   user_transactions_of_sal_month = transactionof_sal_month.where(user_id: @user)
   total_transaction_for_sal_month = user_transactions_of_sal_month.sum(:amount)

   @sal_trans = SalaryTransaction.new(user: @user)
   #Removing Already Paid Salary for the month
   @sal_trans.amount =   salary_for_month - total_transaction_for_sal_month

  end


  def pay_salary
    #code
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end
end
