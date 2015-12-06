Rails.application.routes.draw do
  
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }
  root 'pages#index'

  resources :departments do
    collection do
      post :synchronize
    end
  end
  resources :courses do 
    collection do
      post :synchronize
    end
  end
  resources :sections do
    collection do
      post :synchronize
    end
  end
end
