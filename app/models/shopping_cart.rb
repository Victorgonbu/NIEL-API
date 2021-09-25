class ShoppingCart < ApplicationRecord
  belongs_to :user, optional: true

  has_many :orders, -> {where complete: false}
  has_many :purchases, -> {where complete: true}, class_name: 'Order', foreign_key: 'shopping_cart_id'
  after_touch do |shopping_cart|
    shopping_cart.total = shopping_cart.orders.joins(:license).sum(:price_cents)
    shopping_cart.save
  end
end
