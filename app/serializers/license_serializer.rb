class LicenseSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :number, :price_cents
  has_many :orders
end
