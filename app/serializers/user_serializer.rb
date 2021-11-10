class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :admin
  attribute :authToken do |user|
    JsonWebToken.encode(sub: user.id)
  end
end
