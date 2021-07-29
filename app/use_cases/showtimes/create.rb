module Showtimes
  class Create < UseCase
    arguments :movie_id, :starts_at, :price
    validates_datetime :starts_at
    validates :price, numericality: {greater_than: 0}

    def execution
      movie.showtimes.create!(params.slice(:starts_at, :price))
    end

    private

    def movie
      @movie ||= Movie.find(movie_id)
    end
  end
end
