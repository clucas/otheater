require 'rails_helper'

RSpec.describe "reservations/index", type: :view do
  before(:each) do
    assign(:reservations, [
      Reservation.create!(
        name: "Name",
        venue: nil,
        movie: nil
      ),
      Reservation.create!(
        name: "Name",
        venue: nil,
        movie: nil
      )
    ])
  end

  it "renders a list of reservations" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
