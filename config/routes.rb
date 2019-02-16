Rails.application.routes.draw do
  root to: 'events#index'
  resources :users
  resources :events do
      delete :event_users, to: 'event_users#destroy_all'
      resources :event_users, only:[ :index ,:create, :new ]

  end
  #resources :event_users, only:[ :index ,:create, :new ]
  #delete :event_users, to: 'event_users#destroy_all'
end
