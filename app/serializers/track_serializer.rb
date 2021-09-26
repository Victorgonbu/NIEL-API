class TrackSerializer
  include JSONAPI::Serializer
  attributes :name, :bpm, :pcm, :buyable
end
