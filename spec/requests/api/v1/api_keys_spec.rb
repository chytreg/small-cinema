require "swagger_helper"

RSpec.describe "ApiKeys", type: :request do
  path "/api/v1/api_keys" do
    get "Get api keys assigend to authenticated user" do
      consumes "application/json"
      produces "application/json"
      tags :api_keys
      security [bearerAuth: []]

      before do
        create(:api_key, bearer: current_bearer)
      end

      response "200", "Return all api_keys assigned to current bearer" do
        schema type: :array, items: {"$ref" => "#/components/schemas/api_key"}

        let(:Authorization) { authorization_header }

        run_test! do |response|
          expect(response).to have_http_status(200)
          expect(json.count).to eq(2)
        end
      end

      response "401", "Unauthorized access" do
        let(:Authorization) { "Bearer invalid-token" }

        run_test!
      end
    end

    post "Authenticate and create new api key" do
      consumes "application/json"
      produces "application/json"
      tags :api_keys
      security [basic_auth: []]

      response "201", "new api key created" do
        schema "$ref" => "#/components/schemas/api_key"

        let(:Authorization) { "Basic " + ::Base64.strict_encode64("#{current_bearer.email}:P@ssw0rd!") }

        run_test!
      end

      response "401", "Unauthorized access" do
        let(:Authorization) { "Basic " + ::Base64.strict_encode64("#{current_bearer.email}:wrong-pass") }

        run_test!
      end
    end

    path "/api/v1/api_keys/{id}" do
      delete "Delete api key by id" do
        consumes "application/json"
        produces "application/json"
        tags :api_keys
        security [bearerAuth: []]

        parameter name: :id, in: :path, type: :string, required: true

        let(:Authorization) { authorization_header }
        let(:api_key) do
          create(:api_key, bearer: current_bearer)
        end

        response "204", "api key removed" do
          let(:id) { api_key.id }

          run_test!
        end

        response "404", "api key not found" do
          let(:id) { 999 }

          run_test!
        end
      end
    end
  end
end
