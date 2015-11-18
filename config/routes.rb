Rails.application.routes.draw do
  resources :products

  devise_for :users, controllers: { registrations: 'registrations' }

  root to: redirect('/products'), as: 'root'
end
