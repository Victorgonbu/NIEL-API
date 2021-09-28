class User < ApplicationRecord
  include BCrypt
  REGEX = URI::MailTo::EMAIL_REGEXP
  validates :name, presence: true, length: {minimum: 6, maximum: 20}
  validates :email, presence: true, uniqueness: {case_sensitive: true},
  format: {with: REGEX, message:'Invalid'}
  validates :password_digest, presence: true, length: {minimum: 6}
  validates :country, presence: true

  has_secure_password

  has_many :orders, -> {where complete: false}
  has_many :purchases, -> {where complete: true}, class_name: 'Order'
  
end
