class RenameNumberNameToLicenses < ActiveRecord::Migration[6.1]
  def change
    rename_column :licenses, :number, :uuid
  end
end
