class AlarmSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :file_url, :username

  def file_url
    if object.audio_file.attached?
      rails_blob_path(object.audio_file, disposition: "attachment")
    end
  end

  def username
    object.user.username
  end
end
