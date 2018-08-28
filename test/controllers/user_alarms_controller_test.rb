require 'test_helper'

class UserAlarmsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_alarm = user_alarms(:valid)
  end

  test "should get index" do
    get user_alarms_url, as: :json
    assert_response :success
  end

  test "should create user_alarm" do
    post user_alarms_url, params: @user_alarm, as: :json

    assert_response 201
  end

  test "should show user_alarm" do
    get user_alarm_url(@user_alarm), as: :json
    assert_response :success
  end

  test "should update user_alarm" do
    patch user_alarm_url(@user_alarm), params: { }, as: :json
    assert_response 200
  end

  test "should destroy user_alarm" do
    assert_difference('UserAlarm.count', -1) do
      delete user_alarm_url(@user_alarm), as: :json
    end

    assert_response 204
  end
end
