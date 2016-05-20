Rails.application.routes.draw do

  root 'pages#index'

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  resources :skills

  # Students
  resources :section_preferences
  resources :experiences

  # Instructors
  resources :sections do
    resources :student_preferences
    resources :requirements
  end

  namespace :administrator do
    resources :departments
    resources :courses
    resources :sections
    resources :users
    resources :assignments

    get 'settings' => 'settings#index'
    post 'settings/current_term' => 'settings#set_current_term'
    get 'settings/section_preferences' => 'settings#section_preferences'
    get 'settings/student_preferences' => 'settings#student_preferences'
  end
end
