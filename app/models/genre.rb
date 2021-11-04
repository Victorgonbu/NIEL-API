class Genre < ApplicationRecord
  before_create :slugify

  def slugify
    self.slug = name.parameterize
  end

  has_many :genre_tracks, inverse_of: :genre, dependent: :destroy
  has_many :tracks, through: :genre_tracks

  scope :tracks_by, -> (genre_slug) {
    Genre.find_by_slug!(genre_slug).tracks.order(created_at: :desc)
    .includes(:genres, image_file_attachment: :blob, mp3_file_attachment: :blob,
      wav_file_attachment: :blob, zip_file_attachment: :blob)
  }

end
