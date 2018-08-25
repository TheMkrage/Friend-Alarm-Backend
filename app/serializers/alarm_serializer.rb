class AlarmSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :file_url, :username, :is_high_priority, :is_secret

  def file_url
    if object.audio_file.attached?
      object.audio_file.service_url
    end
  end

  def username
    object.user.username
  end

  def is_high_priority
    if @instance_options[:user_id] != nil
      potential_user_alarm = UserAlarm.where(owner_id: @instance_options[:user_id], alarm_id: object.id).first
      if potential_user_alarm != nil
        return potential_user_alarm.is_high_priority
      end
    end
    return false
  end

  def is_secret
    if @instance_options[:user_id] != nil
      potential_user_alarm = UserAlarm.where(owner_id: @instance_options[:user_id], alarm_id: object.id).first
      if potential_user_alarm != nil
        return potential_user_alarm.is_secret
      end
    end
    return false
  end
end
