require 'rails_helper'

RSpec.describe "venues/edit", type: :view do
  before(:each) do
    @venue = assign(:venue, Venue.create!(
      name: "MyString",
      rows: 1,
      columns: 1
    ))
  end

  it "renders the edit venue form" do
    render

    assert_select "form[action=?][method=?]", venue_path(@venue), "post" do

      assert_select "input[name=?]", "venue[name]"

      assert_select "input[name=?]", "venue[rows]"

      assert_select "input[name=?]", "venue[columns]"
    end
  end
end
