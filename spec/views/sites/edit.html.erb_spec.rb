require 'rails_helper'

RSpec.describe "sites/edit", type: :view do
  before(:each) do
    @site = assign(:site, Site.create!(
      airtable_id: "MyString",
      site_id: "MyString",
      site_name: "MyString",
      address: "MyString"
    ))
  end

  it "renders the edit site form" do
    render

    assert_select "form[action=?][method=?]", site_path(@site), "post" do

      assert_select "input[name=?]", "site[airtable_id]"

      assert_select "input[name=?]", "site[site_id]"

      assert_select "input[name=?]", "site[site_name]"

      assert_select "input[name=?]", "site[address]"
    end
  end
end
