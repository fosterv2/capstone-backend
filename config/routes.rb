Rails.application.routes.draw do
  resources :user_groups
  resources :groups
  resources :follows, only: [:create]
  resources :comments, only: [:show, :create, :destroy]
  resources :posts, only: [:index, :create, :destroy]
  resources :users, only: [:show, :create, :update, :destroy]
  post '/auth', to: 'auth#create'
  get '/auth', to: 'auth#show'
  get '/post_comments/:post_id', to: 'comments#index'
  delete '/destroy_comments/:post_id', to: 'comments#destroy_all'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
