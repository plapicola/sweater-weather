Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show', as: :forecast
      get '/backgrounds', to: 'backgrounds#show', as: :backgrounds
      resources :users, only: [:create]
    end
  end
end
