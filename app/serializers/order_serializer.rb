class OrderSerializer
  include JSONAPI::Serializer
  attributes :token
  belongs_to :orderable, serializer: TrackSerializer
  belongs_to :licenses
  belongs_to :user
end
