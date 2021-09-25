require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  describe 'associations' do
    it {should belong_to(:user).optional(true)}
    it {should have_many(:orders).class_name('Order')}
    it {should have_many(:purchases).class_name('Order')}
  end
end
