class AlarmJob < ApplicationJob
  queue_as :default

  require 'houston'
  APN = Houston::Client.development

  def perform(user, alarm)
    # Ensure this alarm should still go off
    if user.alarm_time == nil
      puts "alarm no longer set"
      return
    end
    alarm_time = Time.parse(user.alarm_time)
    if Time.now > alarm_time + 60 || Time.now < alarm_time - 60
      puts "old job"
      return
    end

    # see if there is a higher priority alarm
    user_alarm = UserAlarm.where(owner_id: user.id, is_high_priority: true).first

    if user_alarm != nil
      high_priority_alarm = user_alarm.alarm
      puts "Found high priority"
      alarm = high_priority_alarm
      user_alarm.is_high_priority = false
      user_alarm.save
    end

    puts alarm
    alarm ||= { id: -1, user: user, name: "ALARM!" }

    APN.certificate = File.read('apple_push_notification_dev.pem')

    # Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
    notification = Houston::Notification.new(device: user.apn_token)
    if user.id == alarm.user.id
      notification.alert = alarm.name
    else
      notification.alert = alarm.name + " from " + alarm.user.username
    end
    # Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
    notification.category = 'ALARM'
    notification.content_available = true
    if alarm.id != -1 && alarm.audio_file.attached?
      notification.custom_data = { isSecond: false, id: alarm.id, url: alarm.audio_file.service_url }
      AlarmFollowupJob.wait(30.second).perform_later(user, alarm)
    else
      notification.custom_data = { isSecond: false, id: alarm.id }
    end
    APN.push(notification)

    # Schedule next alarm
    user.alarm_time = (alarm_time + 1.day).iso8601
    user.save
  end
end
