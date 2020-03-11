Rails.application.routes.draw do
  get 'relationships/follows'
  get 'relationships/followers'
  
  devise_for :users

  resources :books do 
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationship, only: [:create, :destroy, :follows, :followers]
  end

  root 'home#top'
  get 'home/about' => "home#about"
end