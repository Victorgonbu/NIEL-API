class User < ApplicationRecord
  include BCrypt
  REGEX = URI::MailTo::EMAIL_REGEXP
  validates :name, presence: true, length: {minimum: 6, maximum: 30}
  validates :email, presence: true, uniqueness: {case_sensitive: true},
  format: {with: REGEX, message:'Invalid'}
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validates :password_digest, presence: true, length: {minimum: 6}

  has_many :orders, -> {where complete: false}
  has_many :purchases, -> {where complete: true}, class_name: 'Order'
  
  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
