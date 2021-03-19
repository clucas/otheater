class Http::Client
  include HTTParty
  base_uri RapidApi::CONFIG[:config][:base_url]

  def initialize(_options = {})
  end

  def get(path, param_options = {}, header_options = {})
    parse_response(self.class.get(path, query: all_params(param_options), headers: all_headers(header_options)))
  end

  private

  def parse_response(http_response)
    response = Http::Response.new
    response.parse(http_response)
    response
  end

  def all_params(option_params)
    option_params.merge({})
  end

  def all_headers(header_params)
    header_params.merge({})
  end
end