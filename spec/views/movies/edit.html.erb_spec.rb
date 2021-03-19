require 'rails_helper'

RSpec.describe "movies/edit", type: :view do
  before(:each) do
    @movie = assign(:movie, Movie.create!(
      title: "MyString",
      summary: "MyText",
      year: "MyString",
      genre: "MyString",
      image_url: "MyString",
      imdb_link: "MyString"
    ))
  end

  it "renders the edit movie form" do
    render

    assert_select "form[action=?][method=?]", movie_path(@movie), "post" do

      assert_select "input[name=?]", "movie[title]"

      assert_select "textarea[name=?]", "movie[summary]"

      assert_select "input[name=?]", "movie[year]"

      assert_select "input[name=?]", "movie[genre]"

      assert_select "input[name=?]", "movie[image_url]"

      assert_select "input[name=?]", "movie[imdb_link]"
    end
  end
end
