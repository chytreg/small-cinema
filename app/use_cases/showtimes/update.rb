module Showtimes
  class Update < UseCase
    arguments :movie_id, :id, :starts_at, :price
    validates_datetime :starts_at
    validates :price, numericality: {greater_than: 0}

    def execution
      movie.showtimes.find(id).tap do |showtime|
        showtime.update!(params.slice(:starts_at, :price))
      end
    end

    private

    def movie
      @movie ||= Movie.find(movie_id)
    end
  end
end
