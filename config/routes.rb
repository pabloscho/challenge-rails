Rails.application.routes.draw do
  root 'home#index'

  resources :profiles, only: %i[new create]
  resources :reports, only: [:index]

  get '/reports/external', to: 'reports#external'
end
