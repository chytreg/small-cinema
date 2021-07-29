require "swagger_helper"

RSpec.describe "Showtime", type: :request do
  let(:Authorization) { authorization_header }

  let(:movie) { create(:movie) }
  let(:movie_id) { movie.id }

  path "/api/v1/movies/{movie_id}/showtimes" do
    get "Get all showtimes" do
      consumes "application/json"
      produces "application/json"
      tags :showtimes
      security [bearerAuth: []]

      parameter name: :movie_id, in: :path, type: :string, required: true

      before do
        create_list(:showtime, 2, movie: movie)
      end

      response "200", "Return all showtimes" do
        schema type: :array, items: {"$ref" => "#/components/schemas/showtime"}

        run_test! do |response|
          expect(response).to have_http_status(200)
          expect(json.count).to eq(2)
        end
      end
    end

    post "Create showtime record" do
      consumes "application/json"
      produces "application/json"
      tags :showtimes
      security [bearerAuth: []]

      parameter name: :movie_id, in: :path, type: :string, required: true
      parameter_body :showtime_body

      response "200", "Showtime created" do
        schema "$ref" => "#/components/schemas/showtime"

        let(:showtime_body) do
          {showtime: {price: 122, starts_at: 1.day.from_now}}
        end

        run_test!
      end
    end

    path "/api/v1/movies/{movie_id}/showtimes/{id}" do
      put "Update showtime by id" do
        consumes "application/json"
        produces "application/json"
        tags :showtimes
        security [bearerAuth: []]

        parameter name: :movie_id, in: :path, type: :string, required: true
        parameter name: :id, in: :path, type: :string, required: true
        parameter_body :showtime_body

        let(:showtime) do
          create(:showtime, movie: movie)
        end

        response "200", "Showtime updated" do
          let(:id) { showtime.id }

          let(:showtime_body) do
            {showtime: {price: 122, starts_at: 1.day.from_now}}
          end

          run_test!
        end

        response "404", "Showtime not found" do
          let(:id) { 999 }

          let(:showtime_body) do
            {showtime: {price: 122, starts_at: 1.day.from_now}}
          end

          run_test!
        end
      end

      delete "Delete showtime by id" do
        consumes "application/json"
        produces "application/json"
        tags :showtimes
        security [bearerAuth: []]

        parameter name: :movie_id, in: :path, type: :string, required: true
        parameter name: :id, in: :path, type: :string, required: true

        let(:showtime) do
          create(:showtime, movie: movie)
        end

        response "200", "Showtime removed" do
          let(:id) { showtime.id }

          run_test!
        end

        response "404", "Showtime not found" do
          let(:id) { 999 }

          run_test!
        end
      end
    end
  end
end
