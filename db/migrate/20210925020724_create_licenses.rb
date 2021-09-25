class CreateLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :licenses do |t|
      t.string :name
      t.string :description
      t.integer :priice_cents, default: 0, null: false
      t.string :price_currency, default: 'USD', null: false

      t.timestamps
    end
  end
end
