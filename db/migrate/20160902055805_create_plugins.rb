class CreatePlugins < ActiveRecord::Migration[5.0]
  def change
    create_table :plugins do |t|
      t.string :name
      t.string :latest_version

      t.timestamps
    end
  end
end
