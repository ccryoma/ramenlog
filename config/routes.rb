Rails.application.routes.draw do
  get  '/search',  to: 'shops#search'
  get  '/postlist/:id',  to: 'shops#postlist', as: 'postlist'
  get  '/postlistMember/:id',  to: 'members#postlistMember', as: 'postlistMember'
  get  '/map',  to: 'shops#map'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'shops#home'
  get  '/signup',  to: 'members#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get  '/registration',  to: 'shops#new'
  resources :members
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :shops
  resources :posts,          only: [:create, :destroy]
end
