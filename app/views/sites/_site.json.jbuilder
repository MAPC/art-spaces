json.extract! site, :id, :airtable_id, :site_id, :site_name, :address, :created_at, :updated_at
json.url site_url(site, format: :json)
