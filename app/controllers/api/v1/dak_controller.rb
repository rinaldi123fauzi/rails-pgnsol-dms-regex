module Api
  module V1
    class DakController < ApplicationController
      # skip_before_action :logged_in_user
      before_action :has_valid_api_key!
      def index
        documents = Document.joins(:document_type,:sub_document_type,:sub2_document_type,:document_reference,:document_classification).where(document_type_id: 2).select('documents.document_id,documents.document_code,documents.document_date,document_references.reference_name,document_classifications.classification_name,sub_document_types.sub_type_name,sub2_document_types.sub2_type_name,documents.save_date,documents.save_location,documents.file_upload').order('documents.document_date DESC')
        render json: {status: 'SUCCESSFULLY', message:'loaded fields', data:documents}, status: :ok
      end
      def show
        documents = Document.find(params[:id])
        render json: {status: 'SUCCESSFULLY', message:'loaded fields', data:documents}, status: :ok
      end
      # def create
      #   documents = Document.new(field_params)
      #   if documents.save
      #     render json: {status: 'SUCCESSFULLY', message:'saved fields', data:documents}, status: :ok
      #   else
      #     render json: {status: 'Error', message:'Fields is not saved', data:documents.errors}, status: :unprocessable_entity
      #   end
      # end
      # def update
      #   documents = Document.find(params[:id])
      #   if documents.update_attributes(field_params)
      #     render json: {status: 'SUCCESSFULLY', message:'Field is update', data:documents}, status: :ok
      #   else
      #     render json: {status: 'Error', message:'Field is not update', data:documents.errors}, status: :unprocessable_entity
      #   end
      # end
      # def destroy
      #   documents = Document.find(params[:id])
      #   documents.destroy
      #   render json: {status: 'SUCCESSFULLY', message:'Some field has been Deleted', data:documents}, status: :ok
      # end
      private
      def field_params
        params.require(:document).permit(:document_id)
      end
      def has_valid_api_key?
        request.headers['X-Api-Key'] == 'Pg4550Lut1oN!'
      end
      def has_valid_api_key!
        return head :forbidden unless has_valid_api_key?
      end
    end
  end
end
