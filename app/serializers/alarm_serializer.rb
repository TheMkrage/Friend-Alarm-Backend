class AlarmSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :file_url, :username

  def file_url
    if object.audio_file.attached?
      object.audio_file.service_url
    end
  end

  def username
    object.user.username
  end
end
