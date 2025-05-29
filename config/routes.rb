Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations'
  }
  root 'homes#top'
  get 'homes/top'
  get 'users/show' #ログインユーザの詳細画面
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
