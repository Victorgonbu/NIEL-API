class Order < ApplicationRecord
  belongs_to :shopping_cart, touch: true
  belongs_to :orderable, polymorphic: true
  belongs_to :license, optional: true
end
