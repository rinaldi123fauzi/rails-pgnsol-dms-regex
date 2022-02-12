module Api
  module V1
    class FieldsController < ApplicationController
      # skip_before_action :logged_in_user
      before_action :has_valid_api_key!
      def index
        fields = Field.order('created_at DESC');
        render json: {status: 'SUCCESSFULLY', message:'loaded fields', data:fields}, status: :ok
      end
      def show
        fields = Field.find(params[:id])
        render json: {status: 'SUCCESSFULLY', message:'loaded fields', data:fields}, status: :ok
      end
      def create
        fields = Field.new(field_params)
        if fields.save
          render json: {status: 'SUCCESSFULLY', message:'saved fields', data:fields}, status: :ok
        else
          render json: {status: 'Error', message:'Fields is not saved', data:fields.errors}, status: :unprocessable_entity
        end
      end
      def update
        fields = Field.find(params[:id])
        if fields.update_attributes(field_params)
          render json: {status: 'SUCCESSFULLY', message:'Field is update', data:fields}, status: :ok
        else
          render json: {status: 'Error', message:'Field is not update', data:fields.errors}, status: :unprocessable_entity
        end
      end
      def destroy
        fields = Field.find(params[:id])
        fields.destroy
        render json: {status: 'SUCCESSFULLY', message:'Some field has been Deleted', data:fields}, status: :ok
      end
      private
      def field_params
        params.require(:field).permit(:description_field)
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
