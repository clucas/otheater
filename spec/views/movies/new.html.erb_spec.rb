require 'rails_helper'

RSpec.describe "movies/new", type: :view do
  before(:each) do
    assign(:movie, Movie.new(
      title: "MyString",
      summary: "MyText",
      year: "MyString",
      genre: "MyString",
      image_url: "MyString",
      imdb_link: "MyString"
    ))
  end

  it "renders new movie form" do
    render

    assert_select "form[action=?][method=?]", movies_path, "post" do

      assert_select "input[name=?]", "movie[title]"

      assert_select "textarea[name=?]", "movie[summary]"

      assert_select "input[name=?]", "movie[year]"

      assert_select "input[name=?]", "movie[genre]"

      assert_select "input[name=?]", "movie[image_url]"

      assert_select "input[name=?]", "movie[imdb_link]"
    end
  end
end
