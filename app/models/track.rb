class Track < ApplicationRecord
  has_one_attached :image_file, dependent: :destroy
  has_one_attached :mp3_file, dependent: :destroy
  has_one_attached :zip_file, dependent: :destroy
  has_one_attached :wav_file, dependent: :destroy
  has_many :genre_tracks, inverse_of: :track, dependent: :destroy
  has_many :genres, through: :genre_tracks
  has_many :orders, as: :orderable, dependent: :destroy
  has_many :purchases, ->{where complete: true}, as: :orderable, class_name: 'Order', dependent: :destroy
  
  scope :all_tracks, -> {order(created_at: :desc)
    .includes(:genres, image_file_attachment: :blob, mp3_file_attachment: :blob,
      wav_file_attachment: :blob, zip_file_attachment: :blob)
    }

  scope :by_genre, -> (genres_slug) {
    left_outer_joins(:genres).where(genres: {slug: genres_slug}).order(created_at: :desc)
    .includes(:genres, image_file_attachment: :blob, mp3_file_attachment: :blob,
      wav_file_attachment: :blob, zip_file_attachment: :blob).distinct
  }

end
