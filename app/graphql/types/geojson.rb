class Types::Geojson < Types::BaseScalar
  description "A valid GeoJSON object"

  def self.coerce_input(input_value, context)
    # Parse the incoming object into a `URI`
    url = URI.parse(input_value)
    if url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
      # It's valid, return the URI object
      url
    else
      raise GraphQL::CoercionError, "#{input_value.inspect} is not a valid GeoJSON object"
    end
  end

  def self.coerce_result(ruby_value, context)
    RGeo::GeoJSON.encode(ruby_value)
  end
end
