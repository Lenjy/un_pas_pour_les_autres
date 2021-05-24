require 'test_helper'

class StepsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get steps_new_url
    assert_response :success
  end

  test "should get show" do
    get steps_show_url
    assert_response :success
  end

end
