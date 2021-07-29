module Movies
  class Show < UseCase
    arguments :id
    validates :id, presence: true

    def execution
      movie = Movie.find_by!(id: id)
      omdb_movie = Omdb::Movie.fetch_by_id(movie.imdb_id)
      movie.as_json.merge(omdb_movie.as_json)
    end
  end
end
