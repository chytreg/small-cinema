module Movies
  class Create < UseCase
    arguments :imdb_id

    validates :imdb_id, presence: true
    validate :omdb_data_presence
    validate :record_uniqueness

    def execution
      Movie.create!(
        imdb_id: imdb_id,
        title: omdb_movie.title,
        plot: omdb_movie.plot,
        poster: omdb_movie.poster
      )
    end

    private

    def omdb_data_presence
      errors.add(:imdb_id, "record not found in OMDB API") unless omdb_movie
    end

    def record_uniqueness
      errors.add(:imdb_id, "record already exists in database") if Movie.find_by(imdb_id: imdb_id)
    end

    def omdb_movie
      @omdb_movie ||= Omdb::Movie.fetch_by_id(imdb_id)
    end
  end
end
