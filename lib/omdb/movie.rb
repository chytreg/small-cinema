module Omdb
  class Movie < Dry::Struct
    transform_keys do |key|
      key.to_s.underscore.to_sym
    end
    attribute :title, Dry.Types::String
    attribute :year, Dry.Types::String
    attribute :rated, Dry.Types::String
    attribute :released, Dry.Types::String
    attribute :runtime, Dry.Types::String
    attribute :genre, Dry.Types::String
    attribute :director, Dry.Types::String
    attribute :writer, Dry.Types::String
    attribute :actors, Dry.Types::String
    attribute :plot, Dry.Types::String
    attribute :language, Dry.Types::String
    attribute :country, Dry.Types::String
    attribute :awards, Dry.Types::String
    attribute :poster, Dry.Types::String
    attribute :ratings, Dry.Types::Array do
      attribute :source, Dry.Types::String
      attribute :value, Dry.Types::String
    end
    attribute :metascore, Dry.Types::String
    attribute :imdb_rating, Dry.Types::String
    attribute :imdb_votes, Dry.Types::String
    attribute :imdb_id, Dry.Types::String
    attribute :type, Dry.Types::String
    attribute? :total_seasons, Dry.Types::String
    attribute? :dvd, Dry.Types::String
    attribute? :box_office, Dry.Types::String
    attribute? :production, Dry.Types::String
    attribute? :website, Dry.Types::String
    # attribute :response, Dry.Types::Params::Bool

    class << self
      def fetch_by_id(imdb_id)
        Rails.logger.debug "Omdb::Movie.fetch_by_id(#{imdb_id})"
        new(Rails.cache.fetch("#{imdb_id}/omdb_movie_fetch_by_id", expires_in: 1.day) do
          Rails.logger.debug "Omdb::Movie cache miss"
          no_cache_fetch_by_id(imdb_id)
        end)
      end

      def no_cache_fetch_by_id(imdb_id)
        Client.get do |req|
          req.params["i"] = imdb_id
        end.body.tap do |response|
          raise ApplicationError, response["Error"] if response["Error"].present?
        end
      end
    end
  end
end
