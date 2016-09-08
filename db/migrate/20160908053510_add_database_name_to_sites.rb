class AddDatabaseNameToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :database_name, :string
  end
end
