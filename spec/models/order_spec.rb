require 'rails_helper'

RSpec.describe Order, type: :model do
  it {should belong_to(:shopping_cart).touch(true)}
  it {should belong_to(:orderable)}
  it {should belong_to(:license).optional(true)}
end
