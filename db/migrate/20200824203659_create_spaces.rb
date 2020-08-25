class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.string :airtable_id
      t.string :space_id
      t.string :site_id
      t.string :space_name
      t.string :space_description

      t.timestamps
    end
  end
end
