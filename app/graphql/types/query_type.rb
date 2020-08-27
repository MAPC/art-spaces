module Types
  class QueryType < Types::BaseObject
    field :sites, [SiteType], null: false do
      description "List all sites."
    end

    field :site, SiteType, null: true do
      description "Find a site by ID"
      argument :id, ID, required: true
    end

    def site(id:)
      Site.find(id)
    end

    def sites
      Site.all
    end
  end
end
