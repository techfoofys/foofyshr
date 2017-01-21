class FinanceController < ApplicationController
  def salaries
    @salaries = Salary.all
  end
end
