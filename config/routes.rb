Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :vehicle_models, only: [:create]
      resources :vehicle_brands, only: [:create]
      resources :vehicles, only: [:create]

      get '/search/:criteria/:type', to: 'search#search_by_criteria'
    end
  end
end
