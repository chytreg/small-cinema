module Showtimes
  class Index < UseCase
    arguments :movie_id

    def execution
      movie.showtimes
    end

    private

    def movie
      @movie ||= Movie.find(movie_id)
    end
  end
end
