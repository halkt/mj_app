Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  root to: 'static_pages#home'
  resources :users
  resources :horses, only:[ :index, :create, :new, :destroy, :edit, :update]
  resources :events do
      delete :event_users, to: 'event_users#destroy_all'
      resources :event_users, only:[ :index ,:create, :new ]
      resources :games, only:[ :create, :new, :edit, :update ]
  end
end
