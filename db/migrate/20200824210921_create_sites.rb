class CreateSites < ActiveRecord::Migration[6.0]
  def change
    create_table :sites do |t|
      t.string :airtable_id
      t.string :site_id
      t.string :site_name
      t.string :address

      t.timestamps
    end
  end
end
