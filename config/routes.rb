Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#welcome'

  resources :users do
    resources :rooms
    resources :bookings
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
