require 'test_helper'

class LogicControllerTest < ActionController::TestCase
  test "should get ping" do
    get :ping
    assert_response :success
  end

  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get play" do
    get :play
    assert_response :success
  end

end
