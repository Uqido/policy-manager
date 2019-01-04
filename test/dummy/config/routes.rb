Rails.application.routes.draw do
  mount PolicyManager::Engine => "/"

  get "test" => "tests#test"
  get "delete_user" => "tests#delete_user"
end
