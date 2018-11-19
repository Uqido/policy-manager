PolicyManager::Engine.routes.draw do
  resources :policies

  resources :user_policies, only: [:index, :create, :update]
end
