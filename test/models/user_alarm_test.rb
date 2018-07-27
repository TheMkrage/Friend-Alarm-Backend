require 'test_helper'

class UserAlarmTest < ActiveSupport::TestCase
  def setup
    @invalid_user_alarm = alarms(:invalid)
    @valid_user_alarm = alarms(:valid)
  end

  test "default values for is_secret" do
    @valid_user_alarm.valid?
    assert_equal [], @valid_user_alarm.errors[:is_secret]
  end

  test "default values for is_high_priority" do
    @valid_user_alarm.valid?
    assert_equal [], @valid_user_alarm.errors[:is_high_priority]
  end

  test "invalid without is_secret" do
    @invalid_user_alarm.valid?
    assert_not_nil @invalid_user_alarm.errors[:is_secret]
  end

  test "invalid without is_high_priority" do
    @invalid_user_alarm.valid?
    assert_not_nil @invalid_user_alarm.errors[:is_high_priority]
  end

  test "invalid without alarm_id" do
    @invalid_user_alarm.valid?
    assert_not_nil @invalid_user_alarm.errors[:alarm_id]
  end

  test "invalid without referrer_id" do
    @invalid_user_alarm.valid?
    assert_not_nil @invalid_user_alarm.errors[:referrer_id]
  end

  test "invalid without owner_id" do
    @invalid_user_alarm.valid?
    assert_not_nil @invalid_user_alarm.errors[:owner_id]
  end
end
