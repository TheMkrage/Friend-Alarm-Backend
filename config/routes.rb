Rails.application.routes.draw do
  resources :users
  get 'user/search'
end
