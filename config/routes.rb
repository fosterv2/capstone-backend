Rails.application.routes.draw do
  # resources :user_groups
  resources :groups, only: [:index, :create]
  resources :follows, only: [:create]
  resources :comments, only: [:create, :update, :destroy]
  resources :posts, only: [:index, :create, :update, :destroy]
  resources :users, only: [:create, :update]
  post '/auth', to: 'auth#create'
  get '/auth', to: 'auth#show'
  get '/comments/:post_id', to: 'comments#index'
  get '/posts/:group_id', to: 'posts#index_by_group'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
