module Api
  module V1
    class TemplatesController < BaseController
      def index
        templates = YAML.load_file(Rails.root.join("config", "data", "templates.yml"))
        pp templates
        render json: api_response(templates)
        # render json: api_response(nil, message: "Something went wrong", errors: [ "Something went wrong", "asdasd" ]), status: :unprocessable_entity
      end
    end
  end
end
