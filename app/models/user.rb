class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 20 }

  def alarms
    made_alarms = Alarm.where(user_id: self.id)
    referred_alarms = UserAlarm.where(owner_id: self.id).pluck(:alarm)
    alarms = made_alarms + referred_alarms
    return alarms
  end
end
