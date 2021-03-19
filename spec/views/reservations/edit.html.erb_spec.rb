require 'rails_helper'

RSpec.describe "reservations/edit", type: :view do
  before(:each) do
    @reservation = assign(:reservation, Reservation.create!(
      name: "MyString",
      venue: nil,
      movie: nil
    ))
  end

  it "renders the edit reservation form" do
    render

    assert_select "form[action=?][method=?]", reservation_path(@reservation), "post" do

      assert_select "input[name=?]", "reservation[name]"

      assert_select "input[name=?]", "reservation[venue_id]"

      assert_select "input[name=?]", "reservation[movie_id]"
    end
  end
end
