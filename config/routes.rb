Rails.application.routes.draw do
  root 'home#index'
  get 'home/:user_url' => 'home#show'
  get 'home/:user_url/card' => 'home#card'
  post 'home/:user_url/create_card' => 'home#create_card'
  post 'home/:user_url/update_card' => 'home#update_card'
  post 'home/:user_url/delete_card' => 'home#delete_card'
  post 'home/:user_url/update' => 'home#update'
  # event
  resource :events, only: %i[new create]
  post 'events/confirm' => 'events#confirm'
  get 'events/:event_url' => 'events#show'
  get 'events/finish/:event_url' => 'events#finish'
  get 'events/password/:event_url' => 'events#password'
  post 'events/authenticate/:event_url' => 'events#authenticate'
  post 'events/:event_url/pay' => 'events#pay'
  # join
  resource :joins, only: %i[create destroy]
  # item
  resource :items, only: %i[create destroy]
  # devise
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    sessions: 'users/sessions',
                                    confirmations: 'users/confirmations',
                                    registrations: 'users/registrations' }
end
