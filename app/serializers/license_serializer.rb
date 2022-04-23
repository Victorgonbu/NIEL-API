class LicenseSerializer
  include JSONAPI::Serializer
  attributes :uuid, :price_cents
  #has_many :orders

  attribute :name do |object|
    I18n.t("model.license.title.#{object.name}")
  end

  attribute :privileges do |object|
    object.privileges.map { |privilege|  I18n.t("model.license.privileges.#{privilege}") }
  end

  attribute :files do |object|
    object.files.map { |file|  I18n.t("model.license.files.#{file}") }
  end
end
