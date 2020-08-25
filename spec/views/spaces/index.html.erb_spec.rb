require 'rails_helper'

RSpec.describe "spaces/index", type: :view do
  before(:each) do
    assign(:spaces, [
      Space.create!(
        airtable_id: "Airtable",
        space_id: "Space",
        site_id: "Site",
        space_name: "Space Name",
        space_description: "Space Description"
      ),
      Space.create!(
        airtable_id: "Airtable",
        space_id: "Space",
        site_id: "Site",
        space_name: "Space Name",
        space_description: "Space Description"
      )
    ])
  end

  it "renders a list of spaces" do
    render
    assert_select "tr>td", text: "Airtable".to_s, count: 2
    assert_select "tr>td", text: "Space".to_s, count: 2
    assert_select "tr>td", text: "Site".to_s, count: 2
    assert_select "tr>td", text: "Space Name".to_s, count: 2
    assert_select "tr>td", text: "Space Description".to_s, count: 2
  end
end
