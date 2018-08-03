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
end
