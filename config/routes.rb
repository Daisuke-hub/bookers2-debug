Rails.application.routes.draw do
  devise_for :users
  resources :books
  root 'home#top'
  get 'home/about' => "home#about"
  resources :users,only: [:show,:index,:edit,:update]

end