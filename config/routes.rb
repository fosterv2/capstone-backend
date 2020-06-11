Rails.application.routes.draw do
  resources :user_groups, only: [:create]
  resources :groups, only: [:index, :show, :create] # :show only until refactor
  resources :follows, only: [:create]
  resources :comments, only: [:create, :update, :destroy]
  resources :posts, only: [:index, :create, :update, :destroy]
  resources :users, only: [:create, :update]
  post '/auth', to: 'auth#create'
  get '/auth', to: 'auth#show'
  get '/comments/:post_id', to: 'comments#index'
  get '/posts/group/:group_id', to: 'posts#index_by_group' # only until refactor
  patch '/users/:user_id/groups', to: 'users#add_group'
  delete '/users/:user_id/groups', to: 'users#remove_group'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
