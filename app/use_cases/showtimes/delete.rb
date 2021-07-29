module Showtimes
  class Delete < UseCase
    arguments :movie_id, :id

    def execution
      movie.showtimes.find(id).destroy
    end

    private

    def movie
      @movie ||= Movie.find(movie_id)
    end
  end
end
