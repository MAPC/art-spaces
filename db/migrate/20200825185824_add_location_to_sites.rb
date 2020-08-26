class AddLocationToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :location, :st_point, geographic: true
    add_index :sites, :location, using: :gist
  end
end
