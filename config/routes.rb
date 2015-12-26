Rails.application.routes.draw do
  root 'pages#index'

  get 'settings'             => redirect('/settings/profile')
  get 'settings/profile'     => 'settings#profile'
  get 'settings/preferences' => 'settings#preferences'
  get 'settings/skills'      => 'settings#skills'
  resources :users
  resources :skills
  resources :preferences

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  namespace :admin do
    post 'synchronize'   => 'application#synchronize'
    get  'settings'      => 'pages#settings'
    get  'preferences'   => 'reports#preferences'
    resources :departments
    resources :courses, except: [:index]
    resources :sections, except: [:index]
  end
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
end
