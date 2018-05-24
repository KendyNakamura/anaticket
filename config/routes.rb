Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # home
  root 'home#index'
  namespace :home do
    resources :profiles, only: %i[show update], param: :user_url
    resources :cards, only: %i[show create], param: :user_url
    resources :bank, only: %i[new create update], param: :user_url
    post '/cards/:user_url' => 'cards#update'
  end
  # event
  resources :events, param: :event_url, only: %i[show new create destroy]
  resource :purchase, only: %i[create destroy]
  resource :joins, only: %i[create destroy]
  resource :items, only: %i[create destroy]
  post '/events/pay/:event_url' => 'events/pay#create'

  namespace :events do
    resources :pay, only: %i[create], param: :event_url
    resources :confirms, only: %i[show create], param: :event_url
    resources :finish, only: %i[show create], param: :event_url
    resources :password, only: %i[show], param: :event_url
    post '/password/authenticate/:event_url' => 'password#create'
  end

  # devise
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    sessions: 'users/sessions',
                                    confirmations: 'users/confirmations',
                                    registrations: 'users/registrations' }
end
