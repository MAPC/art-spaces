module Types
  class FeatureCollection < Types::BaseObject
    description "A valid GeoJSON FeatureCollection."

    field :type, String, null: false
    field :features, [Feature], null: false

    def type
      'FeatureCollection'
    end

    def features
      Site.all
    end
  end
end
