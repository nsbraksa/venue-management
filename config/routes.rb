Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#welcome'

  resources :users do
    resources :rooms do
      member do
        post 'room_availability'
      end

      collection do
        post 'rooms_availability'
      end
    end
  end

  resources :rooms do
    resources :bookings, except: [:show, :edit, :update, :destroy]
  end

  resources :bookings, only: [:show, :destroy]
end
