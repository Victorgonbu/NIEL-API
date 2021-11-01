class LicenseSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :files, :number, :price_cents
  has_many :orders
end
