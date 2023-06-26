Rails.application.routes.draw do
  root 'home#index'

  post '/api/auth_transactions', to: 'auth_transactions#create'
end
