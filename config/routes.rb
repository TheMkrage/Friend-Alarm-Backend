Rails.application.routes.draw do
  resources :users
  get 'user/search'

  resources :alarms
  resources :user_alarms
end
