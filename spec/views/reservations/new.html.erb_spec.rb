require 'rails_helper'

RSpec.describe "reservations/new", type: :view do
  before(:each) do
    assign(:reservation, Reservation.new(
      name: "MyString",
      venue: nil,
      movie: nil
    ))
  end

  it "renders new reservation form" do
    render

    assert_select "form[action=?][method=?]", reservations_path, "post" do

      assert_select "input[name=?]", "reservation[name]"

      assert_select "input[name=?]", "reservation[venue_id]"

      assert_select "input[name=?]", "reservation[movie_id]"
    end
  end
end
