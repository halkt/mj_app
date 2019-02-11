Rails.application.routes.draw do
  root to: 'events#index'
  resources :users
  resources :events do
    resources :event_users
  end
end
