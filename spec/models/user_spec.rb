require 'rails_helper'

RSpec.describe User, type: :model do
  subject {described_class.new(name: 'name', email: 'email@hotmail.com', 
    password: 'password', password_confirmation: 'password', country: 'Colombia')}
  
  describe 'associations' do 
    it {should have_one(:shopping_cart).class_name('ShoppingCart')}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_length_of(:name)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password_digest)}
    it {should have_secure_password}
    it {should validate_presence_of(:country)}
  end
end
