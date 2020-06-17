Rails.application.routes.draw do
  resources :groups, only: [:index, :create, :update]
  resources :comments, only: [:create]
  resources :posts, only: [:index, :create, :update, :destroy]
  resources :users, only: [:create, :update]
  post '/auth', to: 'auth#create'
  get '/auth', to: 'auth#show'
  get '/comments/:post_id', to: 'comments#index'
  patch '/users/:user_id/groups', to: 'users#add_group'
  delete '/users/:user_id/groups', to: 'users#remove_group'
  patch '/posts/:post_id/likes', to: 'posts#add_like'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
