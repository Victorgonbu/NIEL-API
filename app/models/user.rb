class User < ApplicationRecord
  include BCrypt
  validates :name, presence: true, length: {minimum: 6, maximum: 20}
  validates :email, presence: true, uniqueness: {case_sensitive: true}
  validates :password_hash, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :country, presence: true

  has_one :shopping_cart

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
