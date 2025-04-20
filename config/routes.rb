Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Swagger documentation
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :templates, only: [ :index ]

      resources :documents, only: [] do
        collection do
          get :types
          post :process, action: :process_documents
          post :generate
        end
        member do
          get :download
        end
      end
    end
  end

  # Manejar rutas no encontradas
  match "*path", to: "application#routing_error", via: :all
end
