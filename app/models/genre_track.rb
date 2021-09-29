class GenreTrack < ApplicationRecord
  belongs_to :track, inverse_of: :genre_tracks
  belongs_to :genre, inverse_of: :genre_tracks
end
