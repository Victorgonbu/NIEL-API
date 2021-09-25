class Order < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :orderable
  belongs_to :license
end
