Rails.application.routes.draw do
  devise_for :users
  # booksとfavoritesをネスト
  resources :books do 
    resources :favorites, only: [:create, :destroy]
  end
  root 'home#top'
  get 'home/about' => "home#about"
  resources :users,only: [:show,:index,:edit,:update]

end