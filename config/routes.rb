Rails.application.routes.draw do
  resources :users
  get 'search', to: 'users#search'

  resources :alarms
  resources :user_alarms
end
