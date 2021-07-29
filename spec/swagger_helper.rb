# frozen_string_literal: true

require "rails_helper"

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join("swagger").to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "API V1",
        version: "v1"
      },
      paths: {},
      servers: [
        {
          url: "https://{defaultHost}",
          variables: {
            defaultHost: {
              default: "www.example.com"
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          basic_auth: {
            type: :http,
            scheme: :basic
          },
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            in: :header
          }
        },
        schemas: {
          api_key: {
            type: :object,
            properties: {
              id: {type: :string},
              bearer_id: {type: :string},
              bearer_type: {type: :string}
            },
            required: %w[id]
          },
          movie: {
            type: :object,
            properties: {
              id: {type: :string},
              imdb_id: {type: :string},
              title: {type: :string},
              plot: {type: :string},
              poster: {type: :string}
            },
            required: %w[id imdb_id title plot poster]
          },
          showtime: {
            type: :object,
            properties: {
              id: {type: :string},
              movie_id: {type: :string},
              price: {type: :string},
              starts_at: {type: :string}
            },
            required: %w[id movie_id price starts_at]
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml

  config.after do |example|
    if respond_to?(:response) && response&.body.present?
      example.metadata[:response][:content] = {
        "application/json" => {
          example: JSON.parse(response.body, symbolize_names: true)
        }
      }
    end
  end
end
