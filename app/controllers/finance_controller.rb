class FinanceController < ApplicationController
  before_action :get_user_id, only: [:get_current_salary]

  def salaries
    @salaries = Salary.all
  end

  def get_current_salary
    byebug
    if SalaryTransaction.where(user_id: @user).present?

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
