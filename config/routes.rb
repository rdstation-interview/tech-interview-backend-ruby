Rails.application.routes.draw do
  mount Microservice::Toolkit::HealthCheck::App => '/health_check'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
