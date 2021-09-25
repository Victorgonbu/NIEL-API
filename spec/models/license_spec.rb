require 'rails_helper'

RSpec.describe License, type: :model do
  describe 'associations' do
    it {should have_many(:orders).class_name('Order')}
  end
end
