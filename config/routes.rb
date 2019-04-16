Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show', as: :forecast
      get '/backgrounds', to: 'backgrounds#show', as: :backgrounds
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :favorites, only: [:index, :create]
      delete '/favorites', to: 'favorites#destroy', as: :delete_favorite
    end
  end
end
