class GenreTrack < ApplicationRecord
  belongs_to :track
  belongs_to :genre
end
