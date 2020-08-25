require 'rails_helper'

RSpec.describe "sites/new", type: :view do
  before(:each) do
    assign(:site, Site.new(
      airtable_id: "MyString",
      site_id: "MyString",
      site_name: "MyString",
      address: "MyString"
    ))
  end

  it "renders new site form" do
    render

    assert_select "form[action=?][method=?]", sites_path, "post" do

      assert_select "input[name=?]", "site[airtable_id]"

      assert_select "input[name=?]", "site[site_id]"

      assert_select "input[name=?]", "site[site_name]"

      assert_select "input[name=?]", "site[address]"
    end
  end
end
