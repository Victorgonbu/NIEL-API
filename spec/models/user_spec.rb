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
    it {should validate_presence_of(:password_hash)}
    it {should validate_confirmation_of(:password)}
    it {should validate_presence_of(:password_confirmation)}
    it {should validate_presence_of(:country)}
  end

  describe '#password' do
    it "return encripted password using bcrypt" do
      expect(subject.password.class).to eq(BCrypt::Password)
    end
  end 
  describe '#password=' do
    it "create encripted password using bycrypt and assign it to user password_hash" do
      subject.password = 'new_password'
      expect(subject.password_hash).to be_truthy
    end
  end
end
