module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |err|
      json_error_response(err, :not_found)
    end

    rescue_from UnauthorizedAccessError do |err|
      json_error_response(err, :unauthorized)
    end

    rescue_from ActiveRecord::RecordInvalid, ActiveModel::ValidationError, ApplicationError do |err|
      json_error_response(err, :unprocessable_entity)
    end
  end
end
