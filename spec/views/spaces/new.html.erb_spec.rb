require 'rails_helper'

RSpec.describe "spaces/new", type: :view do
  before(:each) do
    assign(:space, Space.new(
      airtable_id: "MyString",
      space_id: "MyString",
      site_id: "MyString",
      space_name: "MyString",
      space_description: "MyString"
    ))
  end

  it "renders new space form" do
    render

    assert_select "form[action=?][method=?]", spaces_path, "post" do

      assert_select "input[name=?]", "space[airtable_id]"

      assert_select "input[name=?]", "space[space_id]"

      assert_select "input[name=?]", "space[site_id]"

      assert_select "input[name=?]", "space[space_name]"

      assert_select "input[name=?]", "space[space_description]"
    end
  end
end
