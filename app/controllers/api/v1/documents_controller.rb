module Api
  module V1
    class DocumentsController < BaseController
      def types
        types = YAML.load_file(Rails.root.join("config", "data", "document_types.yml"))
        render json: api_response(types["types"])
      end

      def process_documents
        template_id = params[:template_id]

        # Seleccionar el archivo de datos según el template
        data_file = {
          "template-hipoteca" => "processed_documents.yml",
          "template-arrendamiento" => "processed_documents_arrendamiento.yml",
          "template-credito-vehicular" => "processed_documents_vehicular.yml"
        }.fetch(template_id, "processed_documents.yml")

        processed = YAML.load_file(Rails.root.join("config", "data", data_file))
        render json: api_response(processed)
      end

      def generate
        template_id = params[:template_id]

        # Personalizar el nombre del documento generado según el template
        document_name = case template_id
        when "template-hipoteca"
          "solicitud_hipoteca_juan_perez.pdf"
        when "template-arrendamiento"
          "contrato_arrendamiento_maria_lopez.pdf"
        when "template-credito-vehicular"
          "solicitud_credito_vehicular_carlos_rodriguez.pdf"
        else
          "documento_generado.pdf"
        end

        generated = YAML.load_file(Rails.root.join("config", "data", "generated_document.yml"))
        generated["generated_document"]["name"] = document_name
        generated["generated_document"]["gdrive_id"] = "gdrive-#{template_id}-001"
        generated["generated_document"]["url"] = "https://drive.google.com/file/d/gdrive-#{template_id}-001/view"

        render json: api_response(generated)
      end

      def download
        # Mock PDF response
        send_file(
          Rails.root.join("public", "sample.pdf"),
          filename: "documento_#{SecureRandom.hex(4)}.pdf",
          type: "application/pdf",
          disposition: "attachment"
        )
      end
    end
  end
end
