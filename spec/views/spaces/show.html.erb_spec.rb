require 'rails_helper'

RSpec.describe "spaces/show", type: :view do
  before(:each) do
    @space = assign(:space, Space.create!(
      airtable_id: "Airtable",
      space_id: "Space",
      site_id: "Site",
      space_name: "Space Name",
      space_description: "Space Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Airtable/)
    expect(rendered).to match(/Space/)
    expect(rendered).to match(/Site/)
    expect(rendered).to match(/Space Name/)
    expect(rendered).to match(/Space Description/)
  end
end
