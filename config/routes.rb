Rails.application.routes.draw do
  get  '/search',  to: 'shops#search'
  get  '/postlist/:id',  to: 'shops#postlist', as: 'postlist'
  get  '/postlist_member/:id',  to: 'members#postlist_member', as: 'postlist_member'
  get  '/map',  to: 'shops#map'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'shops#home'
  get  '/signup',  to: 'members#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/guest_login', to: 'sessions#new_guest'
  get  '/registration',  to: 'shops#new'
  resources :members
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :shops
  resources :posts,          only: [:create, :destroy]
end
