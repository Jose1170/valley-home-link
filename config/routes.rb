Rails.application.routes.draw do
  get "bookings/index"
  get "bookings/show"
  get "bookings/edit"
  get "bookings/update"
  root "sessions#new"
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'sessions'
  delete 'logout', to: 'sessions#destroy'

  resources :users

  resources :job_requests do
    member do
      patch :accept
    end
  end

  resources :bookings, only: [:index, :show, :edit, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #root "job_requests#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
