json.extract! reservation, :id, :name, :venue_id, :movie_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
