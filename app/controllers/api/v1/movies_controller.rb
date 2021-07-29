module Api
  module V1
    class MoviesController < ApplicationController
      def index
        # TODO: Add suport for filtering and pagination
        render json: Movies::Index.call(params: {})
      end

      def show
        render json: Movies::Show.call(params: params.slice(:id))
      end

      def rate
        # TODO: Implement rating
      end
    end
  end
end
