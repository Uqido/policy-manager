Rails.application.routes.draw do
  mount PolicyManager::Engine => "/"

  get "test" => "tests#test"
end
