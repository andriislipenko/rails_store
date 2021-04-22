Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'}

  root 'items#index'
  resources :orders, only: [:index, :new, :create]

  get '/cart', to: 'orders#show_cart', as: 'cart'
  get '/cart/clear', to: 'orders#clear_cart', as: 'clear_cart'
  delete '/cart/:id', to: 'orders#remove_from_cart', as: 'remove_from_cart'
end
