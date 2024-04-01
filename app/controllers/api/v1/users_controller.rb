# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show]
      skip_before_action :authorized, only: %i[create]
      rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

      def show
        render json: {
          user: Api::V1::UserSerializer.new(@user)
        }, status: :ok
      end

      def create
        user = User.create!(user_params)
        @token = encode_token(user_id: user.id)
        render json: {
          user: Api::V1::UserSerializer.new(user),
          token: @token
        }, status: :created
      end

      def me
        render json: current_user, status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:full_name, :email, :password)
      end

      def handle_invalid_record(err)
        render json: { errors: err.record.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
