PolicyManager::Engine.routes.draw do
  resources :policies

  resources :user_policies, only: [:index, :create, :update] do
    collection do
      put :bulk_update
    end
  end

  resources :portability_requests, only: [:index, :create] do
    member do
      get :attachment
    end
  end

  resources :logs, only: [:index]
end
