module Omdb
  class Connection
    attr_reader :base_url, :client

    def initialize
      @base_url = "https://www.omdbapi.com/?apikey=#{Rails.application.credentials.fetch(:omdb_api_key)}"
      @client = Faraday.new(base_url) do |c|
        c.adapter Faraday.default_adapter

        c.request :url_encoded
        c.response :json, content_type: /\bjson$/
        c.response :raise_error
        c.response :logger, Rails.logger
      end
    end
  end
end
