Rails.application.routes.draw do
  resources :products, only: [:index, :show]

  namespace :admin do
    resources :products
  end



  devise_scope :user do
    authenticated :user do
      root to: redirect('/admin/products'), as: 'authenticated'
    end
    unauthenticated :user do
      root to: redirect('/products'), as: 'unauthenticated'
    end
  end

  devise_for :users
end
