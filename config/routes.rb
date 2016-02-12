Rails.application.routes.draw do

  root 'pages#index'
  get 'about' => 'pages#about'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  namespace :students do
    resources :skills
    resources :preferences
    resources :users
  end

  namespace :instructors do
  end

  namespace :administrators do
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
