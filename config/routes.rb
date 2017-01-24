Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' } do
    get "logout", to: "devise/sessions#destroy"
  end
  resources :authentications do
    collection do
      post :add_provider
    end
  end
  
  namespace :admin do
    resources :projects
  end
  
  match '/users/auth/:provider/callback' => 'authentications#create', :via => :get
  delete '/users/signout' => 'devise/sessions#destroy', :as => :signout
  root to: 'home#index'
  
  
end
