Rails.application.routes.draw do
  get 'rankings/show'
  get 'mypages/show'
  root to: 'mypages#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'static_pages/help'
  namespace :admin do
    resources :users
    resources :communities
    resources :horses, only:[ :index, :create, :new, :destroy, :edit, :update]
  end
  resources :events do
    resources :games, only:[ :create, :new, :edit, :update, :show, :destroy ]
  end

  # API用
  namespace :api do
    get 'users/users_list', to: 'users#users_list'
  end
end
