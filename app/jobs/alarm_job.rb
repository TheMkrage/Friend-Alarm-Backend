class AlarmJob < ApplicationJob
  queue_as :default

  require 'houston'
  APN = Houston::Client.development

  def perform(user, alarm)

    APN.certificate = File.read('apple_push_notification_dev.pem')
    puts "sent"
    puts user.apn_token
    # Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
    notification = Houston::Notification.new(device: user.apn_token)
    notification.alert = 'Hello, World!'

    # Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
    notification.badge = 57
    # notification.sound = 'sosumi.aiff'
    notification.category = 'INVITE_CATEGORY'
    notification.content_available = true
    notification.custom_data = { foo: 'bar' }

    # And... sent! That's all it takes.
    APN.push(notification)
  end
end
