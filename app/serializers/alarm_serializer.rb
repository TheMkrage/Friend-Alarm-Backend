class AlarmSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :file_url, :username

  def file_url
    if object.audio_file.attached?
      url_for(object.audio_file)
    end
  end

  def username
    object.user.username
  end
end
