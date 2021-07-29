# frozen_string_literal: true

module AuthorizationHelper
  def current_bearer
    @current_bearer ||= FactoryBot.create(:user)
  end

  def token
    return @token if defined? @token

    @token = ApiKeys::Create.call(params: {email: current_bearer.email, password: "P@ssw0rd!"})
  end

  def authorization_header
    "Bearer #{token.fetch(:token)}"
  end
end

RSpec.configure do |config|
  config.include AuthorizationHelper, type: :request
end
