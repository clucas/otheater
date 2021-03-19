require 'rails_helper'

RSpec.describe "movies/show", type: :view do
  before(:each) do
    @movie = assign(:movie, Movie.create!(
      title: "Title",
      summary: "MyText",
      year: "Year",
      genre: "Genre",
      image_url: "Image Url",
      imdb_link: "Imdb Link"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Year/)
    expect(rendered).to match(/Genre/)
    expect(rendered).to match(/Image Url/)
    expect(rendered).to match(/Imdb Link/)
  end
end
