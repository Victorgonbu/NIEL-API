class AddNumberColumnToLicenses < ActiveRecord::Migration[6.1]
  def change
    add_column :licenses, :number, :integer, index: true
  end
end
