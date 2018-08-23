class AlarmJob < ApplicationJob
  queue_as :default

  require 'houston'
  APN = Houston::Client.development

  def perform(user, alarm)
    if user.alarm_time == nil
      puts "alarm no longer set"
      return
    end
    alarm_time = Time.parse(user.alarm_time)
    if Time.now > alarm_time + 60 || Time.now < alarm_time - 60
      puts "old job"
      return
    end

    APN.certificate = File.read('apple_push_notification_dev.pem')

    # Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
    notification = Houston::Notification.new(device: user.apn_token)
    notification.alert = alarm.name + " from " + alarm.user.username
    # Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
    notification.category = 'ALARM'
    notification.content_available = true
    if alarm.audio_file.attached?
      notification.custom_data = { id: alarm.id, url: alarm.audio_file.service_url }
    else
      notification.custom_data = { id: alarm.id }
    end
    APN.push(notification)

    # Schedule next alarm
    user.alarm_time = (alarm_time + 1.day).iso8601
    user.save
  end
end
