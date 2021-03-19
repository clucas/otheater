require 'rails_helper'

RSpec.describe "movies/index", type: :view do
  before(:each) do
    assign(:movies, [
      Movie.create!(
        title: "Title",
        summary: "MyText",
        year: "Year",
        genre: "Genre",
        image_url: "Image Url",
        imdb_link: "Imdb Link"
      ),
      Movie.create!(
        title: "Title",
        summary: "MyText",
        year: "Year",
        genre: "Genre",
        image_url: "Image Url",
        imdb_link: "Imdb Link"
      )
    ])
  end

  it "renders a list of movies" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Year".to_s, count: 2
    assert_select "tr>td", text: "Genre".to_s, count: 2
    assert_select "tr>td", text: "Image Url".to_s, count: 2
    assert_select "tr>td", text: "Imdb Link".to_s, count: 2
  end
end
