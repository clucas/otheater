class MovieService
  include Singleton

  # cd249c7729msh11f4c143961e1bdp1d52f5jsn3fa7ac5fdc44
  def fetch_most_popular_movies
    ActiveRecord::Base.transaction do
      begin
        popular_movies_path = RapidApi::CONFIG[:config][:popular_movies_path]
        movie_path = RapidApi::CONFIG[:config][:movie_overview_details_path]
        response = api_client.get(popular_movies_path, {}, header_options)
        if response.valid?
          movie_list = response.body
          movie_list.first(50).each do |movie_id|
            sleep(0.1) # I think the free version of the API is throttling
            response = api_client.get(movie_path, { tconst: movie_id.gsub('/title/', '') }, header_options)
            movie_info = response.body
            movie_options = {
                imdb_id: movie_info[:id].gsub('/title/', '').gsub('/', '') ,
                title: movie_info.dig(:title, :title),
                summary: "",
                year: movie_info.dig(:title, :year).to_s,
                genre: movie_info[:genres].to_a.join(','),
                image_url: movie_info.dig(:title, :image, :url),
                imdb_link: "http://imdb.com#{movie_info[:id]}"
            }
            Movie.create_or_find_by(movie_options)
          end
        else
          raise response.error[:message]
        end
      rescue StandardError => e
        log("Error fetching movies: #{e.message}")
        log("Error fetching movies: #{e.backtrace.join('\n')}")
        raise "Error fetching movies"
      end
    end
  end

  private

  def api_client
    if @api_client.nil?
      @api_client = Http::Client.new()
    end
    @api_client
  end

  def header_options
    {
        "x-rapidapi-key": Rails.application.credentials.api_keys[:rapid_api_key],
        "x-rapidapi-host": URI(RapidApi::CONFIG[:config][:base_url]).host
    }
  end

  def parse_character(result)
    {
        name: result[:name],
        marvel_uuid: result[:id],
        description: result[:description],
        picture_url: "#{result[:thumbnail][:path]}.#{result[:thumbnail][:extension]}"
    }
  end

  def log(message)
    Rails.logger.info message
  end
end