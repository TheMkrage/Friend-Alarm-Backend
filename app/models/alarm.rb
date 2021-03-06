class Alarm < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :duration, presence: true
  validates :user_id, presence: true

  has_one_attached :audio_file
  belongs_to :user
end
