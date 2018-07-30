class UserAlarm < ApplicationRecord
  validates :alarm_id, presence: true
  validates :referrer_id, presence: true
  validates :owner_id, presence: true

  belongs_to :alarm
  belongs_to :referrer, class_name: 'User'
  belongs_to :owner, class_name: 'User'

end
