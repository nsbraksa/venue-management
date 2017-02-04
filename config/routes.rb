Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#welcome'

  resources :users do
    resources :rooms do
      member do
        post 'availability'
      end

      resources :bookings, only: [:new, :create]
    end
    resources :bookings, only: [:index]
  end
end
