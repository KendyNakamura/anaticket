Rails.application.routes.draw do
  root 'home#index'
  get 'home/:id' => 'home#show'
  post 'home/:id/update' => 'home#update'
  # event
  resource :events, only: %i[new create]
  post 'events/confirm' => 'events#confirm'
  get 'events/:id' => 'events#show'
  # join
  resource :joins, only: %i[create destroy]
  # devise
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    sessions: 'users/sessions',
                                    confirmations: 'users/confirmations',
                                    registrations: 'users/registrations' }
end
