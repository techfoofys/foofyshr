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
    sal_per_month = 0
    
    if !UserProfile.where(user_id: user_id).first.probation.nil?

      if  UserProfile.where(user_id: user_id).first.probation
        sal = Salary.where(user_id: user_id).first.initial_amount_per_month
        sal_per_month = sal
        salary_month = Time.now - 1.month
        days = Time.days_in_month(salary_month.month, salary_month.year)
        sal_per_day = sal_per_month / days



        doj = UserProfile.where(user_id: user_id).first.doj

        probation_period = UserProfile.where(user_id: user_id).first.user.salary.prov_period
        probation_end_date = doj + probation_period.month
        probation_end_date = probation_end_date - 1.day
        start_month = salary_month.beginning_of_month
        end_month = salary_month.end_of_month

        if probation_end_date >= start_month && probation_end_date <= end_month
          ## Employee probation is going to over this month
          probation_days = (probation_end_date.to_date - start_month.to_date).to_i + 1

          sal = Salary.where(user_id: user_id).first.initial_amount_per_month
          sal_per_month = sal
          salary_month = Time.now - 1.month
          days = Time.days_in_month(salary_month.month, salary_month.year)
          sal_per_day = sal_per_month / days


          probation_sal = sal_per_day * probation_days
          regular_days = (end_month.to_date - probation_end_date.to_date )

          #Calculating Regular salary per day
          sal = Salary.where(user_id: user_id).first.amount
          sal_per_month = sal / 12
          salary_month = Time.now - 1.month
          days = Time.days_in_month(salary_month.month, salary_month.year)
          reg_sal_per_day = sal_per_month / days

          reg_sal = reg_sal_per_day *  regular_days

          #Final Salary for a person some for probation and remaing for regular
          salary_for_month = (probation_sal +  reg_sal).round

        else
          #Final Slalary for Probation Period
          salary_for_month =   (working_days * sal_per_day).round
        end

      else
        # Final Salary for Reqular user
        sal = Salary.where(user_id: user_id).first.amount
        sal_per_month = sal / 12
        salary_month = Time.now - 1.month
        days = Time.days_in_month(salary_month.month, salary_month.year)
        sal_per_day = sal_per_month / days

        doj = UserProfile.where(user_id: user_id).first.doj

        probation_period = UserProfile.where(user_id: user_id).first.user.salary.prov_period
        probation_end_date = doj + probation_period.month
        probation_end_date = probation_end_date - 1.day
        start_month = salary_month.beginning_of_month
        end_month = salary_month.end_of_month

        if probation_end_date >= start_month && probation_end_date <= end_month
          ## Employee probation is going to over this month
          probation_days = (probation_end_date.to_date - start_month.to_date).to_i + 1

          ##Calculate Probation salary
          prob_sal_per_month = Salary.where(user_id: user_id).first.initial_amount_per_month
          prob_sal_per_day = prob_sal_per_month / days
          probation_sal = prob_sal_per_day * probation_days
          regular_days = (end_month.to_date - probation_end_date.to_date )

          #Calculating Regular salary per day
          sal = Salary.where(user_id: user_id).first.amount
          sal_per_month = sal / 12
          salary_month = Time.now - 1.month
          days = Time.days_in_month(salary_month.month, salary_month.year)
          reg_sal_per_day = sal_per_month / days

          reg_sal = reg_sal_per_day *  regular_days

          #Final Salary for a person some for probation and remaing for regular
          salary_for_month = (probation_sal +  reg_sal).round

        else
          salary_for_month =   (working_days * sal_per_day).round
        end
      end

    end

    return salary_for_month

  end

  def calculate_partial_salary(user_id)
    sal_month = Time.now - 1.month
    transactionof_sal_month = SalaryTransaction.where( "extract(month from month) = ?", sal_month.month  )
    user_transactions_of_sal_month = transactionof_sal_month.where(user_id: user_id)
    total_transaction_for_sal_month = user_transactions_of_sal_month.sum(:amount)

    return total_transaction_for_sal_month.round

  end

  def final_amount(user_id)
    calculate_salary(user_id) - calculate_partial_salary(user_id)
  end


end
