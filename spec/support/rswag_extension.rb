module RswagExtension
  def parameter_body(name)
    parameter name: name,
      in: :body,
      required: true,
      schema: {
        type: :object,
        properties: {
          name => {
            "$ref" => "#/components/schemas/#{name}"
          }
        }
      }
  end
end

RSpec.configure do |config|
  config.extend RswagExtension, type: :request
end
