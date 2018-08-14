Rails.application.routes.draw do
  resources :users
  get 'users/:id/alarms', to: 'users#alarms'
  get 'search', to: 'users#search'

  resources :alarms
  resources :user_alarms
end
