Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_scope :user do
  #   delete :sign_out, to: 'devise/sessions#destroy', as: :destroy_user_session
  # end
  root 'home#index'
  get 'event/new' => 'home#new_event'
  resource :event, only: [:create]
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
end
