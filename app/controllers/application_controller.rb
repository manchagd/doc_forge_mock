class ApplicationController < ActionController::API
  rescue_from StandardError do |e|
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def api_response(data = nil, message: nil, errors: nil)
    {
      data: data,
      message: message,
      errors: errors
    }.compact
  end
end
