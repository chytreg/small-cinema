class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ApiKeyAuthenticable
  include ExceptionHandler

  prepend_before_action :authenticate_with_api_key!

  protected

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_error_response(err, status = :unprocessable_entity)
    json_response({errors: [{message: err.message}]}, status)
  end
end
