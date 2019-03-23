Rails.application.routes.draw do
  get 'mypages/show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  #get 'static_pages/home'
  get 'static_pages/help'
  namespace :admin do
    resources :users
    resources :horses, only:[ :index, :create, :new, :destroy, :edit, :update]
  end
  #resources :users
  root to: 'mypages#show'
  resources :events do
      delete :event_users, to: 'event_users#destroy_all'
      #resources :event_users, only:[ :index ,:create, :new ]
      resources :games, only:[ :create, :new, :edit, :update, :show, :destroy ]
  end
end
