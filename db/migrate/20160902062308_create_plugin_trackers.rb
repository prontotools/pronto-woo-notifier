class CreatePluginTrackers < ActiveRecord::Migration[5.0]
  def change
    create_table :plugin_trackers do |t|
      t.belongs_to :site, index: true
      t.belongs_to :plugin, index: true
      t.string :current_version
      t.timestamps
    end
  end
end
