require 'uri'
require 'net/http'
require 'openssl'
require 'json'

url = URI("https://imdb8.p.rapidapi.com/title/get-most-popular-movies?homeCountry=US&purchaseCountry=US&currentCountry=US")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-key"] = 'cd249c7729msh11f4c143961e1bdp1d52f5jsn3fa7ac5fdc44'
request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'

response = http.request(request)
movie_list = JSON.parse(response.body)

movie_list.each do |movie|
  url = URI("https://imdb8.p.rapidapi.com/title/get-overview-details?tconst=#{movie.gsub('/title/', '')}")
  # url = URI("https://imdb8.p.rapidapi.com/title/get-details?tconst=#{movie.gsub('/title/', '')}")
  sleep(1)
  movie_request = Net::HTTP::Get.new(url)
  movie_request["x-rapidapi-key"] = 'cd249c7729msh11f4c143961e1bdp1d52f5jsn3fa7ac5fdc44'
  movie_request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'
  response = http.request(movie_request)
  movie_info = JSON.parse(response.body)
  # m = {
  #     title: movie_info['title'],
  #     summary: "",
  #     year: movie_info['year'],
  #     genre: "",
  #     image: movie_info['image']['url'],
  #     link: "http://imdb.com#{movie_info['id']}"
  # }

  pp movie_info['genres']
  m = {
      title: movie_info['title']['title'],
      summary: "",
      year: movie_info['title']['year'].to_s,
      genre: movie_info['genres'].join('/'),
      image: movie_info['title']['image']['url'],
      link: "http://imdb.com#{movie_info['id']}"
  }

  pp m
end