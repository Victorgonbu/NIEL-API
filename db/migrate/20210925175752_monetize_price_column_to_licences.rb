class MonetizePriceColumnToLicences < ActiveRecord::Migration[6.1]
  def change
    remove_column :licenses, :priice_cents, :integer
    remove_column :licenses, :price_currency, :string
    add_monetize :licenses, :price
  end
end
