Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
 
  root 'dashboard#index' 

  resources :users, only:[:show, :update] do
    get :all_online, on: :collection
  end
  resources :authorizations, only:[:new, :create]

  resources :chat_rooms, only: [:new, :create, :show, :index]
 

  mount ActionCable.server => '/cable'
end
