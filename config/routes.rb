Rails.application.routes.draw do
  resources :products

  devise_scope :user do
    authenticated :user do
      root to: redirect('/products'), as: 'authenticated'
    end
    unauthenticated :user do
      root to: redirect('/products'), as: 'unauthenticated'
    end
  end

  devise_for :users
end
