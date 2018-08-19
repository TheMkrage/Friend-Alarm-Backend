Rails.application.routes.draw do
  resources :users
  get 'users/:id/alarms', to: 'users#alarms'
  post 'users/:id/schedule', to: 'users#schedule_alarm'
  get 'search', to: 'users#search'

  resources :alarms
  resources :user_alarms
end
