Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
 
  root 'dashboard#index'
  resources :policies, only:[] do
    get :privacy, on: :collection
  end
  resources :authorizations, only:[:new, :create]
end
