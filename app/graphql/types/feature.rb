module Types
  class Feature < Types::BaseObject
    description "A valid GeoJSON Feature."

    field :type, String, null: false
    field :geometry, Types::Geojson, null: false # use location field
    field :properties, GraphQL::Types::JSON, null: false

    def type
      'Feature'
    end

    def geometry
      object.location
    end

    def properties
      object.attributes.slice('site_name')
    end
  end
end
