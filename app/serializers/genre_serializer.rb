class GenreSerializer
  include JSONAPI::Serializer
  attributes :name, :slug, :icon
  has_many :tracks, through: :genre_tracks
end
