PolicyManager::Engine.routes.draw do
  resources :policies

  resources :user_policies, only: [:create, :update]
end
