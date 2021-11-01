class Genre < ApplicationRecord
  before_create :slugify

  def slugify
    self.slug = name.parameterize
  end

  has_many :genre_tracks, inverse_of: :genre, dependent: :destroy
  has_many :tracks, through: :genre_tracks

end
