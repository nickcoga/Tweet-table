Rails.application.routes.draw do
  # get 'user/show'
  # get 'tweet/index'
  # get 'tweet/new'
  # get 'tweet/create'
  # get 'tweet/edit'
  # get 'tweet/show'
  # get 'tweet/update'
  # get 'tweet/destroy'
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' } # controller q se hara cargo de los call es 'callbacks'

  # para omni
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  root to: 'tweets#index'
  resources :tweets
  # post 'tweets/:id/add_tweet' => 'tweets#create'
  resources :users do
    get 'profile_tweets', on: :member
    get 'profile_likes', on: :member
  end

  resources :tweets do
    resources :likes
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
