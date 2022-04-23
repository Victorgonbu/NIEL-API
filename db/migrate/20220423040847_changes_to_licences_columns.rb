class ChangesToLicencesColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :licenses, :description, :string
    remove_column :licenses, :files, :string
    add_column :licenses, :privileges, :string, array: true, default: []
    add_column :licenses, :files, :string, array: true, default: []
  end
end
