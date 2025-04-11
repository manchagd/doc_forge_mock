module Api
  module V1
    class DocumentsController < ApplicationController
      def index
        render json: {
          documents: [
            {
              id: 1,
              title: "Documento 1",
              content: "Contenido del documento 1",
              created_at: Time.current,
              updated_at: Time.current
            },
            {
              id: 2,
              title: "Documento 2",
              content: "Contenido del documento 2",
              created_at: Time.current,
              updated_at: Time.current
            }
          ]
        }
      end

      def show
        render json: {
          document: {
            id: params[:id],
            title: "Documento #{params[:id]}",
            content: "Contenido del documento #{params[:id]}",
            created_at: Time.current,
            updated_at: Time.current
          }
        }
      end

      def create
        render json: {
          document: {
            id: 3,
            title: params[:title],
            content: params[:content],
            created_at: Time.current,
            updated_at: Time.current
          }
        }, status: :created
      end

      def update
        render json: {
          document: {
            id: params[:id],
            title: params[:title],
            content: params[:content],
            created_at: Time.current,
            updated_at: Time.current
          }
        }
      end

      def destroy
        head :no_content
      end

      def types
        types = YAML.load_file(Rails.root.join("config", "data", "document_types.yml"))
        render json: api_response(types["types"])
      end

      def process_documents
        template_id = params[:template_id]

        # Seleccionar el archivo de datos según el template
        data_file = case template_id
        when "template-hipoteca"
                     "processed_documents.yml"
        when "template-arrendamiento"
                     "processed_documents_arrendamiento.yml"
        when "template-credito-vehicular"
                     "processed_documents_vehicular.yml"
        else
                     "processed_documents.yml" # Default
        end

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
          filename: "document.pdf",
          type: "application/pdf",
          disposition: "attachment"
        )
      end
    end
  end
end
