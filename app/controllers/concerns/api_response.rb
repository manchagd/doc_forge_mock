module ApiResponse
  extend ActiveSupport::Concern

  def api_response(result, message: nil, errors: nil)
    {
      result: result,
      message: message,
      errors: errors
    }
  end
end
