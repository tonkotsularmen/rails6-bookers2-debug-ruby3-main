Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end#users/guest_sign_in への POST リクエストが users/sessions#guest_sign_in アクションにルーティングされるように設定しています

  root to: "homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    get "search", to: "users#search"
  end

  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  
  get 'tagsearches/search', to: 'tagsearches#search'
  get "search" => "searches#search", as: 'search'
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end