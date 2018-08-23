require 'test_helper'

class AlarmJobTest < ActiveJob::TestCase

  setup do
    @user = users(:valid)
  end

  test "alarm_time chage" do
    alarm_time = Time.now
    @user.alarm_time = alarm_time
    @user.save
    AlarmJob.perform_now @user, alarms(:valid)
    @user.reload
    assert_equal (alarm_time + 1.days).iso8601, @user.alarm_time
  end
end
