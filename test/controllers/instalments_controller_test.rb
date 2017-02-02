require 'test_helper'

class InstalmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @instalment = instalments(:one)
  end

  test "should get index" do
    get instalments_url
    assert_response :success
  end

  test "should get new" do
    get new_instalment_url
    assert_response :success
  end

  test "should create instalment" do
    assert_difference('Instalment.count') do
      post instalments_url, params: { instalment: { amount: @instalment.amount, instalment_date: @instalment.instalment_date, instalment_no: @instalment.instalment_no, project_id: @instalment.project_id } }
    end

    assert_redirected_to instalment_url(Instalment.last)
  end

  test "should show instalment" do
    get instalment_url(@instalment)
    assert_response :success
  end

  test "should get edit" do
    get edit_instalment_url(@instalment)
    assert_response :success
  end

  test "should update instalment" do
    patch instalment_url(@instalment), params: { instalment: { amount: @instalment.amount, instalment_date: @instalment.instalment_date, instalment_no: @instalment.instalment_no, project_id: @instalment.project_id } }
    assert_redirected_to instalment_url(@instalment)
  end

  test "should destroy instalment" do
    assert_difference('Instalment.count', -1) do
      delete instalment_url(@instalment)
    end

    assert_redirected_to instalments_url
  end
end
