require 'test_helper'

class AlarmTest < ActiveSupport::TestCase

  def setup
    @invalid_alarm = alarms(:invalid)
    @valid_alarm = alarms(:valid)
  end

  test "invalid long name" do
    @invalid_alarm.valid?
    assert_not_nil @invalid_alarm.errors[:name]
  end

  test "invalid without name" do
    no_name_alarm = @valid_alarm
    no_name_alarm.name = nil
    no_name_alarm.valid?
    assert_not_nil no_name_alarm.errors[:name]
  end

  test "invalid without duration" do
    no_name_alarm = @valid_alarm
    no_name_alarm.duration = nil
    no_name_alarm.valid?
    assert_not_nil no_name_alarm.errors[:duration]
  end

  test "invalid without user_id" do
    no_name_alarm = @valid_alarm
    no_name_alarm.user_id = nil
    no_name_alarm.valid?
    assert_not_nil no_name_alarm.errors[:user_id]
  end

end
