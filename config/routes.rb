Rails.application.routes.draw do
  get 'rankings/show'
  get 'mypages/show'
  root to: 'mypages#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'static_pages/help'
  get '/sample', to: 'sample#index', as: 'sample'
  namespace :admin do
    resources :users
    resources :communities
    resources :horses, only:[ :index, :create, :new, :destroy, :edit, :update]
  end
  resources :events do
      delete :event_users, to: 'event_users#destroy_all'
      resources :games, only:[ :create, :new, :edit, :update, :show, :destroy ]
  end
end
