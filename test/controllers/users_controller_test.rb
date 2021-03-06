require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:valid)
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: @user, as: :json
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { }, as: :json
    assert_response 200
  end

  test "search" do
    search_url = "/search?query=u"
    get search_url, as: :json
    assert_response 200
  end

  test "get alarms from user" do
    url = user_url(@user) + "/alarms"
    get url, as: :json
    assert_response 200
  end

  test "schedule alarm" do
    url = user_url(@user) + "/schedule"
    post url, params: { alarm_id: alarms(:valid).id, time: "2018-08-17T04:58:17.000Z" }, as: :json
    assert_response 200
  end

  test "unschedule alarm" do
    @user.alarm_time = Time.now
    @user.save
    url = user_url(@user) + "/schedule"
    delete url, as: :json
    @user.reload
    assert_nil @user.alarm_time
  end
end
