PolicyManager::Engine.routes.draw do
  # get 'policies/:id', to: 'policies#show'

  resources :policies
end
