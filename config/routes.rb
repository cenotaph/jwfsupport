Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' } 
  devise_scope :user do
     get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
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
  
  resources :users do
    get :theme_switch
  end

  post '/search', to: 'search#create'
  resources :tickets do
    resources :comments
  end
  
  match '/users/auth/:provider/callback' => 'authentications#create', :via => :get
  match '/hashtag' => 'tickets#hashtag', via: :get
  authenticated :user do
    root to: 'tickets#index', opened: "true", as: :authenticated_root
  end
  root to: 'tickets#landing'
 
end
