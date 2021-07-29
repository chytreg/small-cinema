FactoryBot.define do
  factory :movie do
    sequence(:imdb_id) { |n| "tt023250#{n}" }
    title { "The Fast and the Furious" }
    plot { "Los Angeles police officer Brian O'Conner must decide where his loyalty really lies when he becomes enamored with the street racing world he has been sent undercover to destroy." }
    poster { "https://m.media-amazon.com/images/M/MV5BNzlkNzVjMDMtOTdhZC00MGE1LTkxODctMzFmMjkwZmMxZjFhXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg" }
  end
end
