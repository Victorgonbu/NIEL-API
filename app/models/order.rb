class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :orderable, polymorphic: true
  belongs_to :license, optional: true
end
