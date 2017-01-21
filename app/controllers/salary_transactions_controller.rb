class SalaryTransactionsController < InheritedResources::Base

  private

    def salary_transaction_params
      params.require(:salary_transaction).permit(:user_id, :month, :amount)
    end
end

