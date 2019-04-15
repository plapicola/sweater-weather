Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show', as: :forecast
      get '/backgrounds', to: 'backgrounds#show', as: :backgrounds
      get '/antipode', to: 'antipodes#show', as: :antipode
      resources :users, only: [:create]
      resources :sessions, only: [:create]
    end
  end
end
