Rails.application.routes.draw do
  root 'homes#top'

  #reservationモデル用のルーティング
  resources :reservations do
    collection do
      post :confirm
      patch :confirm
    end
  end

  #roomモデル用のルーティング
  get 'rooms/own', as: :rooms_own
  resources :rooms 

  #userモデル用のルーティング
  devise_for :users, controllers: {
  registrations: 'users/registrations'
  }
  #deviseの標準ルーティングに組み込む
  devise_scope :user do
  get 'users/profile/edit', to: 'users/registrations#edit_profile', as: :users_edit_profile
  patch 'users/profile/update', to: 'users/registrations#update_profile', as: :users_update_profile
  end

  #モデルと関係ないページ用
  get 'homes/top'
  get 'users/account' 
  get 'users/profile' 

  #get 'users/profile/edit', to: 'users/registrations#edit_profile', as: :users_edit_profile

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
