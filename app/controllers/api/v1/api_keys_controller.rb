module Api
  module V1
    class ApiKeysController < ApplicationController
      skip_before_action :authenticate_with_api_key!, only: %i[create]

      def index
        render json: current_bearer.api_keys
      end

      def create
        authenticate_with_http_basic do |email, password|
          render(
            json: ApiKeys::Create.call(params: {email: email, password: password}),
            status: :created
          ) and return
        end

        raise UnauthorizedAccessError, "Unauthorized access"
      end

      def destroy
        current_bearer.api_keys.find(params[:id]).destroy
      end
    end
  end
end
