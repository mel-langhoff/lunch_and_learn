Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get "recipes", to: "recipes#index"
      get "tourist_sites", to: "tourist_sites#index"
      get "learning_resources", to: "learning_resources#index"

      post "users", to: "users#create"

      post "sessions", to: "sessions#create"

      resources :favorites, only: [:index, :create]
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
