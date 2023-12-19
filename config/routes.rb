Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  root to: 'homes#top'
  resources :posts do
    resources :comments, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
  end

  resources :users, only: %i[index show edit update destroy] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: %i[create destroy]
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
