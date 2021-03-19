module Http
  class Response
    attr_reader :error
    attr_reader :url
    attr_reader :status_code
    attr_reader :successful
    attr_reader :headers
    attr_accessor :body

    def initialize(attributes = {})
      @successful = false
      @body = nil
      @headers = nil
      @url = attributes[:url]
      @error = attributes[:error]
      @status_code = attributes[:status_code] || 0
    end

    def valid?
      (200..299).include?(@status_code.to_i)
    end

    def parse(http_response)
      @status_code = http_response.code
      @headers = http_response.headers
      if valid?
        @successful = true
        parse_content(http_response)
      else
        if http_response.headers['content-type'].to_s.include?('json')
          @error = JSON.parse(http_response.body, symbolize_names: true)
        else
          @error = http_response.body
        end
      end
    end

    private

    def parse_content(http_response)
      begin
        if http_response.headers['content-type'].to_s.include?('json')
          @body = JSON.parse(http_response.body, symbolize_names: true)
        else
          @body = http_response.body
        end
      rescue JSON::ParserError => error
        @error = error.message
      end
    end
  end
end