require 'rails_helper'

RSpec.describe "sites/show", type: :view do
  before(:each) do
    @site = assign(:site, Site.create!(
      airtable_id: "Airtable",
      site_id: "Site",
      site_name: "Site Name",
      address: "Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Airtable/)
    expect(rendered).to match(/Site/)
    expect(rendered).to match(/Site Name/)
    expect(rendered).to match(/Address/)
  end
end
