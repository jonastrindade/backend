# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  namespace :api, default: { format: :json } do
    namespace :v1, default: { format: :json } do
      resources :users, only: %i[show create]
      get "/me", to: "users#me"
      post "/authentications/login", to: "authentications#login"
    end
  end
end
