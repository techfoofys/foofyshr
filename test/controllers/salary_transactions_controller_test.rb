require 'test_helper'

class SalaryTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salary_transaction = salary_transactions(:one)
  end

  test "should get index" do
    get salary_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_salary_transaction_url
    assert_response :success
  end

  test "should create salary_transaction" do
    assert_difference('SalaryTransaction.count') do
      post salary_transactions_url, params: { salary_transaction: { amount: @salary_transaction.amount, month: @salary_transaction.month, user_id: @salary_transaction.user_id } }
    end

    assert_redirected_to salary_transaction_url(SalaryTransaction.last)
  end

  test "should show salary_transaction" do
    get salary_transaction_url(@salary_transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_salary_transaction_url(@salary_transaction)
    assert_response :success
  end

  test "should update salary_transaction" do
    patch salary_transaction_url(@salary_transaction), params: { salary_transaction: { amount: @salary_transaction.amount, month: @salary_transaction.month, user_id: @salary_transaction.user_id } }
    assert_redirected_to salary_transaction_url(@salary_transaction)
  end

  test "should destroy salary_transaction" do
    assert_difference('SalaryTransaction.count', -1) do
      delete salary_transaction_url(@salary_transaction)
    end

    assert_redirected_to salary_transactions_url
  end
end
