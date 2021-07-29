module Movies
  class Index < UseCase
    def execution
      Movie.all
    end
  end
end
