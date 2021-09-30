class RemoveCountryFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :country, :string
  end
end
