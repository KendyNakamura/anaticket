Rails.application.routes.draw do
  root 'home#index'
  get 'home/:user_url' => 'home#show'
  post 'home/:user_url/update' => 'home#update'
  # event
  resource :events, only: %i[new create]
  post 'events/confirm' => 'events#confirm'
  get 'events/:event_url' => 'events#show'
  get 'events/finish/:event_url' => 'events#finish'
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
