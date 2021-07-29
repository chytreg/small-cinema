FactoryBot.define do
  factory :omdb_movie, class: "Omdb::Movie" do
    imdb_id do
      ["tt0232500", "tt0322259", "tt0463985", "tt1013752",
        "tt1596343", "tt1905041", "tt2820852", "tt4630562"].sample
    end

    initialize_with {
      file = File.read(Rails.root.join("spec/fixtures/tt0322259.json"))
      new(JSON.parse(file).merge(attributes))
    }
  end
end
