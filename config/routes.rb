PolicyManager::Engine.routes.draw do
  resources :policies

  resources :user_policies, only: [:index, :create, :update]

  resources :portability_requests, only: [:index, :create] do
    member do
      get :attachment
    end
  end
end
