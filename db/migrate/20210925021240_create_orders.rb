class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :shopping_cart, null: false, foreign_key: true
      t.references :orderable, null: false, polymorphic: true
      t.references :license, null: false, foreign_key: true
      t.boolean :complete, default: false
      t.string :token

      t.timestamps
    end
  end
end
