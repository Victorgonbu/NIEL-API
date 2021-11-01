class AddFilesColumnToLicenses < ActiveRecord::Migration[6.1]
  def change
    add_column :licenses, :files, :string
  end
end
