module FinanceHelper
  def get_working_days(user_id)
     salary_month = Time.now - 1.month
     days = Time.days_in_month(salary_month.month, salary_month.year)

     if  UserProfile.where(user_id: user_id).first.doj < Time.now - 1.month
       working_days = days
     else
       #First Salary
        user_date_oj = UserProfile.where(user_id: user_id).first.doj.day
        working_days = days - user_date_oj
     end
  end

  def calculate_salary(user_id)
    working_days = get_working_days(user_id)

    if !UserProfile.where(user_id: user_id).first.probation.nil?

      if  UserProfile.where(user_id: user_id).first.probation
        sal = Salary.where(user_id: user_id).first.initial_amount_per_month
        sal_per_month = sal
      else
        sal = Salary.where(user_id: user_id).first.amount
        sal_per_month = sal / 12
      end

    end



    salary_month = Time.now - 1.month
    days = Time.days_in_month(salary_month.month, salary_month.year)

    sal_per_day = sal_per_month / days

    return  (working_days * sal_per_day).round

  end

  def calculate_partial_salary(user_id)
    sal_month = Time.now - 1.month
    transactionof_sal_month = SalaryTransaction.where( "cast(strftime('%m', month) as int) = ?", sal_month.month  )
    user_transactions_of_sal_month = transactionof_sal_month.where(user_id: user_id)
    total_transaction_for_sal_month = user_transactions_of_sal_month.sum(:amount)

    return total_transaction_for_sal_month.round

  end

  def final_amount(user_id)
    calculate_salary(user_id) - calculate_partial_salary(user_id)
  end


end
