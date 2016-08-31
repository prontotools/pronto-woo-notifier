class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :domain
      t.string :port

      t.timestamps
    end
  end
end
