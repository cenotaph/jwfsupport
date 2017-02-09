Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' } do
    delete "/users/sign_out" => "devise/sessions#destroy"

  end
  resources :authentications do
    collection do
      post :add_provider
    end
  end
  
  resources :projects do
    resources :users
  end
      
  
  namespace :admin do
    resources :projects
  end
  
  resources :users

  resources :tickets do
    resources :comments
  end
  
  match '/users/auth/:provider/callback' => 'authentications#create', :via => :get

  authenticated :user do
    root to: 'tickets#index', as: :authenticated_root
  end
  root to: 'tickets#landing'
  
end
