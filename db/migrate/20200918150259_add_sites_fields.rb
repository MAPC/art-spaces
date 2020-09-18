class AddSitesFields < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :description, :string
    add_column :sites, :count_of_spaces, :integer
    add_column :sites, :vision_db_link, :string
    add_column :sites, :zillow_link, :string
    add_column :sites, :organization_link, :string
  end
end
