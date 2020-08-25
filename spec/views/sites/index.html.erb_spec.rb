require 'rails_helper'

RSpec.describe "sites/index", type: :view do
  before(:each) do
    assign(:sites, [
      Site.create!(
        airtable_id: "Airtable",
        site_id: "Site",
        site_name: "Site Name",
        address: "Address"
      ),
      Site.create!(
        airtable_id: "Airtable",
        site_id: "Site",
        site_name: "Site Name",
        address: "Address"
      )
    ])
  end

  it "renders a list of sites" do
    render
    assert_select "tr>td", text: "Airtable".to_s, count: 2
    assert_select "tr>td", text: "Site".to_s, count: 2
    assert_select "tr>td", text: "Site Name".to_s, count: 2
    assert_select "tr>td", text: "Address".to_s, count: 2
  end
end
