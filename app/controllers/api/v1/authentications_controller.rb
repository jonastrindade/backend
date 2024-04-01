# frozen_string_literal: true

module Api
  module V1
    class AuthenticationsController < ApplicationController
      skip_before_action :authorized, only: [:login]
      rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

      def login
        @user = User.find_by!(email: login_params[:email])
        if @user.authenticate(login_params[:password])
          @token = encode_token(user_id: @user.id)
          render json: {
            user: Api::V1::UserSerializer.new(@user),
            token: @token
          }, status: :accepted
        else
          render json: { message: 'Incorrect password' }, status: :unauthorized
        end
      end

      private

      def login_params
        params.require(:user).permit(:email, :password)
      end

      def handle_record_not_found(_err)
        render json: { message: "User doesn't exist" }, status: :unauthorized
      end
    end
  end
end
