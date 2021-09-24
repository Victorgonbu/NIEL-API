class AddNullTrueToShoppingCartsUser < ActiveRecord::Migration[6.1]
  def change
    change_column_null :shopping_carts, :user_id, true
  end
end
