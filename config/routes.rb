Rails.application.routes.draw do
  resources :user_groups, only: [:create]
  resources :groups, only: [:index, :show, :create]
  resources :follows, only: [:create]
  resources :comments, only: [:create, :update, :destroy]
  resources :posts, only: [:index, :show, :create, :update, :destroy]
  resources :users, only: [:create, :update]
  post '/auth', to: 'auth#create'
  get '/auth', to: 'auth#show'
  get '/comments/:post_id', to: 'comments#index'
  get '/posts/group/:group_id', to: 'posts#index_by_group'
  # get '/groups/user/:user_id', to: 'groups#index_by_user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
