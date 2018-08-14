class AlarmSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :file_url, :username

  def file_url
    if self.audio_file.attached?
      self.audio_file.service_url
    end
  end

  def username
    object.user.username
  end
end
