class Genre < ApplicationRecord
  before_create :slugify


  def slugify
    self.slug = name.parameterize
  end

  has_many :genre_tracks
  has_many :tracks, through: :genre_tracks

end
