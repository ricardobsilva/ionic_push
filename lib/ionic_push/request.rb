require 'httparty'

module IonicPush
  class Request
    include HTTParty

    base_uri IonicPush::BASE_URI

    def initialize(configuration, data)
      @configuration = configuration
      @data = data
      @options = {}
    end

    def send
      self.class.post("/notifications", request_params)
    end

    private

    def headers
      {headers: {'Content-Type': 'application/json', 'Authorization': "Bearer #{@configuration.api_key}"}}
    end

    def body
      profile
      {body: @data.to_json }
    end

    def profile
      @data.merge!({profile: @configuration.profile})
    end

    def request_params
      @options.merge!(headers)
      @options.merge!(body)
    end
  end
end
