Rails.application.routes.draw do
  # 1. Root path (Where users land first)
  root "sessions#new"

  # 2. Authentication (Login/Logout/Signup)
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'sessions'
  delete 'logout', to: 'sessions#destroy'
  
  # Add these two lines here:
  get 'signup', to: 'registrations#new'
  post 'signup', to: 'registrations#create'

  # 3. Main Resources
  resources :users
  resources :bookings, only: [:index, :show, :edit, :update]

  resources :job_requests do
    member do
      patch :accept
    end
  end

  # 4. System health check
  get "up" => "rails/health#show", as: :rails_health_check
end