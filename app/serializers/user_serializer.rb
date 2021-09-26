class UserSerializer
  include JSONAPI::Serializer
  attributes :name
  attribute :authToken do |user|
    JsonWebToken.encode(sub: user.id)
  end
end
