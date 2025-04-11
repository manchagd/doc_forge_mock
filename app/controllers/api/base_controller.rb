module Api
  class BaseController < ApplicationController
    include ApiResponse

    rescue_from StandardError, with: :render_error
    rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
    rescue_from ActionController::RoutingError, with: :render_not_found

    private

    def render_error(error)
      render json: api_response(nil, errors: [ error.message ]), status: :internal_server_error
    end

    def render_parameter_missing(error)
      render json: api_response(nil, errors: [ "Parámetro requerido: #{error.param}" ]), status: :bad_request
    end

    def render_not_found(error)
      render json: api_response(nil, errors: [ "Recurso no encontrado" ]), status: :not_found
    end
  end
end
