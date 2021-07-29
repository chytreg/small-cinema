module Api
  module V1
    class ShowtimesController < ApplicationController
      prepend_before_action :authenticate_with_api_key!

      def index
        # TODO: Add suport for filtering and pagination
        render json: Showtimes::Index.call(params: {movie_id: params[:movie_id]})
      end

      def create
        render json: Showtimes::Create.call(
          params: showtime_params.merge(
            movie_id: params[:movie_id]
          )
        )
      end

      def update
        render json: Showtimes::Update.call(
          params: showtime_params.merge(
            movie_id: params[:movie_id],
            id: params[:id]
          )
        )
      end

      def destroy
        render json: Showtimes::Delete.call(
          params: {movie_id: params[:movie_id], id: params[:id]}
        )
      end

      private

      def showtime_params
        params.require(:showtime).permit(
          :starts_at, :price
        )
      end
    end
  end
end
