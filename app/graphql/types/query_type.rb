module Types
  class QueryType < Types::BaseObject
    field :site, SiteType, null: true do
      description "Find a site by ID"
      argument :id, ID, required: true
    end

    def site(id:)
      Site.find(id)
    end
  end
end
