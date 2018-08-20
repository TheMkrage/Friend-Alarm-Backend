class AlarmJob < ApplicationJob
  queue_as :default

  require 'houston'
  APN = Houston::Client.development

  def perform(user, alarm)

    APN.certificate = File.read('apple_push_notification_dev.pem')

    # Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
    notification = Houston::Notification.new(device: user.apn_token)
    puts "helo"
    notification.alert = alarm.name + " from " + alarm.user.username
    puts user.apn_token
    # Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
    notification.category = 'ALARM'
    notification.content_available = true
    if alarm.audio_file.attached?
      notification.custom_data = { id: alarm.id, url: alarm.audio_file.service_url }
    else
      notification.custom_data = { id: alarm.id }
    end
    #puts notification.custom_data
    # And... sent! That's all it takes.
    APN.push(notification)
  end
end
