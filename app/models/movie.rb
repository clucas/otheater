class Movie < ApplicationRecord

  def self.load_popular_movies
    MovieService.instance.fetch_most_popular_movies
    Movie.all
  end
end
