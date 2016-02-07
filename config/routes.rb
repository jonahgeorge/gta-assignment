Rails.application.routes.draw do

  root 'pages#index'
  get 'about' => 'pages#about'

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  namespace :student do
    resources :skills_users
    resources :preferences
    resources :users
  end

  namespace :instructor do
  end

  namespace :administrator do
    resources :departments
    resources :courses, except: [:index]
    resources :sections, except: [:index]
    resources :users
    get 'settings'               => 'pages#settings'
    get 'synchronize'            => 'base#synchronize'
    get 'student_preferences'    => 'reports#student_preferences'
    get 'instructor_preferences' => 'reports#instructor_preferences'
    get 'assignment'             => 'assignment#index'
  end

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
end
