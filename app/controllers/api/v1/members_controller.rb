module Api
  module V1
    class MembersController < ApplicationController
      # skip_before_action :logged_in_user
      before_action :has_valid_api_key!
      def index
        members = Member.order('created_at DESC');
        render json: {status: 'SUCCESSFULLY', message: 'loaded members', data: members}, status: :ok
      end

      def show
        members = Member.find(params[:id])
        render json: {status: 'SUCCESSFULLY', message: 'loaded members', data: members}, status: :ok
      end

      def create
        members = Member.new(member_params)
        if members.save
          render json: {status: 'SUCCESSFULLY', message: 'Members is saved', data: members}, status: :ok
        else
          render json: {status: 'Error', message: 'Members is not saved', data: members.errors}, status: :unprocessable_entity
        end
      end

      private

      def member_params
        params.require(:member).permit(:username, :password, :password_confirmation, :nama, :email, :last_login)
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
