# frozen_string_literal: true

module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :full_name, :email, :created_at, :updated_at
    end
  end
end
