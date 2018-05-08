Rails.application.routes.draw do
  root 'home#index'
  # event
  resource :events, only: %i[new create]
  get 'events/:id' => 'events#show'
  # join
  resource :joins, only: %i[create destroy]
  # devise
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
