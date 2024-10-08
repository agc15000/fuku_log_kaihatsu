Rails.application.routes.draw do
  devise_for :users
  resources :rooms, only: [:index, :create, :show] do
    resources :messages, only: [:create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :relationships, only: [:create, :destroy]
  resources :userlists, only: [:index, :show] do
    collection do
      match 'search' => 'userlists#index', via: [:get, :post], as: :search
    end
    member do
      post 'follow', to: 'relationships#create'
      delete 'unfollow', to: 'relationships#destroy'
      get 'followlist'
    end
  end

  resources :cloths do
    collection do
      get 'search'
    end
    resources :episodes, except: [:timeline]
  end

  get 'timeline' => 'episodes#timeline'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  authenticated :user do
    root to: "cloths#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "welcome#top", as: :unauthenticated_root
  end
end
