module Types
  class SpaceType < Types::BaseObject
    field :id, ID, null: false
    field :airtable_id, String, null: true
    field :space_id, String, null: true
    field :site_id, String, null: true
    field :space_name, String, null: true
    field :space_description, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
