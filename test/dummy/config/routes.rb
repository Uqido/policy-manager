Rails.application.routes.draw do
  mount PolicyManager::Engine => "/policy_manager"
end
