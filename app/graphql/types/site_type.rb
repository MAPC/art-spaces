module Types
  class SiteType < Types::BaseObject
    field :id, ID, null: false
    field :airtable_id, String, null: true
    field :site_id, String, null: true
    field :site_name, String, null: true
    field :address, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :location, Types::Geojson, null: true
  end
end
