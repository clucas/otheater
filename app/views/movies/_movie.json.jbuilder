json.extract! movie, :id, :imdb_id, :title, :summary, :year, :genre, :image_url, :imdb_link, :created_at, :updated_at
json.url movie_url(movie, format: :json)
