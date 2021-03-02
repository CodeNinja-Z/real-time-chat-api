Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#authenticate'
      post 'signup', to: 'users#create'

      resources :channels, only: %i[index show]
      resources :user_channels, only: %i[create]

      root "channels#index"
    end
  end
end
