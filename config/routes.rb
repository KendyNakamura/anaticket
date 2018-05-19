Rails.application.routes.draw do
  # home
  root 'home#index'
  namespace :home do
    resources :profiles, only: %i[show update], param: :user_url
    resources :cards, only: %i[show create update], param: :user_url
  end
  # event
  resources :events, param: :event_url, only: %i[show new create destroy]
  resource :purchase, only: %i[create destroy]
  resources :joins, only: %i[create destroy]
  resource :items, only: %i[create destroy]

  namespace :events do
    resource :pay, only: %i[create]
    resources :confirms, only: %i[show create], param: :event_url
    resources :finish, only: %i[show create], param: :event_url
    resource :password, only: %i[show create]
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
