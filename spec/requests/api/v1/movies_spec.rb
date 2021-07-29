require "swagger_helper"

RSpec.describe "Movies", type: :request do
  let(:Authorization) { authorization_header }

  path "/api/v1/movies" do
    get "Get list of movies" do
      consumes "application/json"
      produces "application/json"
      tags :movies
      security [bearerAuth: []]

      before do
        create_list(:movie, 2)
      end

      response "200", "List of movies" do
        schema type: :array, items: {"$ref" => "#/components/schemas/movie"}

        run_test! do |response|
          expect(response).to have_http_status(200)
          expect(json.count).to eq(2)
        end
      end
    end

    path "/api/v1/movies/{id}" do
      get "Get movie data by id" do
        consumes "application/json"
        produces "application/json"
        tags :movies
        security [bearerAuth: []]

        parameter name: :id, in: :path, type: :string, required: true, description: "id"

        let(:movie) { create(:movie) }

        response "200", "Details of movie" do
          schema "$ref" => "#/components/schemas/movie"

          before do
            expect(Omdb::Movie).to receive(:fetch_by_id).and_return(build(:omdb_movie, imdb_id: movie.imdb_id))
          end

          let(:id) { movie.id }
          run_test!
        end

        response "404", "Movie not found" do
          before do
            expect(Omdb::Movie).to_not receive(:fetch_by_id)
          end

          let(:id) { 999 }
          run_test!
        end
      end
    end
  end
end
