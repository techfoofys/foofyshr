class FinanceController < ApplicationController
  before_action :get_user_id, only: [:get_current_salary]
    layout false, only: [ :get_current_salary  ]

  def salaries
    @salaries = Salary.all
  end

  def get_current_salary
    if SalaryTransaction.where(user_id: @user).present?

    else
      @sal_trans = SalaryTransaction.new(user: @user)

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
