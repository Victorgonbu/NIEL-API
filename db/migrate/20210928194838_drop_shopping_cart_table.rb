class DropShoppingCartTable < ActiveRecord::Migration[6.1]
  def change
    
    remove_reference :orders, :shopping_cart, index: true, foreign_key: true
    add_reference :orders, :user, index: true, foreign_key: true
    drop_table :shopping_carts
  end
end
