require 'rails_helper'

RSpec.describe "venues/index", type: :view do
  before(:each) do
    assign(:venues, [
      Venue.create!(
        name: "Name",
        rows: 2,
        columns: 3
      ),
      Venue.create!(
        name: "Name",
        rows: 2,
        columns: 3
      )
    ])
  end

  it "renders a list of venues" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
