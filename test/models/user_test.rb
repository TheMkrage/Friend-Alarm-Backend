require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @invalid_user= users(:invalid)
    @valid_user= users(:valid)
  end

  test "invalid long username" do
    @invalid_user.valid?
    assert_not_nil @invalid_user.errors[:username]
  end

  test "invalid without username" do
    no_username_user = @valid_user
    no_username_user.username = nil
    no_username_user.valid?
    assert_not_nil no_username_user.errors[:username]
  end
end
